package app

import (
	"errors"
	"flag"
	"fmt"
	"os"
	"stocktrack_server/config/database"
	"stocktrack_server/middlewares/logErrors/logErrorsRepository"
	"stocktrack_server/middlewares/logErrors/logErrorsUsecase"
	dbModel "stocktrack_server/models/dbmodel"
	"stocktrack_server/routes/checkHealthRoutes"
	"stocktrack_server/routes/itemRoutes"
	"stocktrack_server/routes/supplierRoutes"
	"stocktrack_server/routes/userRoutes"
	"strconv"
	"time"

	"github.com/gin-contrib/cors"
	"github.com/gin-contrib/logger"
	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
	"gorm.io/gorm"
)

/*
initializeDomainModule initializes and configures the domain modules and their respective
routes for the application.

Parameters:
  - v1Group (gin.RouterGroup): The Gin RouterGroup where the routes for domain modules will be added.
  - conn (*gorm.DB): The GORM database connection used by the domain modules.

Example:

	initializeDomainModule(v1Group, conn)
*/
func initializeDomainModule(v1Group *gin.RouterGroup, conn *gorm.DB) {
	// Create a repository for logging errors
	logErrorRepo := logErrorsRepository.NewLogErrorsRepository(conn)

	// Create a use case for logging errors
	logUC := logErrorsUsecase.NewLogErrorsUsecase(logErrorRepo)

	// Initialize and configure routes for different domain modules
	checkHealthRoutes.CheckHealthRoutes(v1Group)
	userRoutes.UserRoutes(v1Group, conn, logUC)
	supplierRoutes.SupplierRoutes(v1Group, conn, logUC)
	itemRoutes.ItemRoutes(v1Group, conn, logUC)
}

/*
initEnv initializes and loads environment variables required for configuring the database connection.

This function reads configuration parameters from an environment file (typically a .env file) and
sets up the database connection details, including host, port, user, password, database name, and
connection pool settings.

Parameters:
  - dbConfig (dbModel.DBConfig): A struct that holds the database configuration.
  - err (error): An error that may occur during the initialization process.

Returns:
  - dbConfig (dbModel.DBConfig): The populated database configuration.
  - err (error): An error if any issues occur during initialization.

Example:

	dbConfig, err := initEnv()
	if err != nil {
		log.Error().Msg("initEnv.err: " + err.Error())
		return
	}
*/
func initEnv() (dbConfig dbModel.DBConfig, err error) {
	// Read environment variables from an .env file
	err = godotenv.Load("config/files/.env")
	if err != nil {
		return dbConfig, errors.New("initEnv.err: " + err.Error())
	}

	// Retrieve environment variables for database configuration
	port := os.Getenv("PORT")
	if port == "" {
		log.Error().Msg("port cannot be empty")
		return
	}
	dbHost := os.Getenv("DB_HOST")
	dbPort := os.Getenv("DB_PORT")
	dbUser := os.Getenv("DB_USER")
	dbPass := os.Getenv("DB_PASS")
	dbName := os.Getenv("DB_NAME")
	maxIdle := os.Getenv("MAX_IDLE")
	maxConn := os.Getenv("MAX_CONN")
	maxLifeTime := os.Getenv("MAX_LIFE_TIME")

	// Convert and assign configuration values
	dbConfig.MaxIdle, err = strconv.Atoi(maxIdle)
	if err != nil {
		return dbConfig, err
	}
	dbConfig.MaxConn, err = strconv.Atoi(maxConn)
	if err != nil {
		return dbConfig, err
	}
	dbConfig.Host = dbHost
	dbConfig.DbPort = dbPort
	dbConfig.User = dbUser
	dbConfig.Pass = dbPass
	dbConfig.Database = dbName
	dbConfig.MaxLifeTime = maxLifeTime
	dbConfig.Port = port

	// Then return dbConfig
	return dbConfig, nil
}

/*
RunService initializes and starts the core services of the application.

This function performs several crucial tasks, including initializing environment variables,
setting up the database connection, configuring the HTTP server, enabling middleware such as
CORS and logging, and defining API routes for the application.

Usage:
Call the `RunService` function from the `main` package to start the application.

Example:

	func main() {
		app.RunService()
	}

Notes:
- This function should be the entry point of your application.
- Ensure that you have updated the `version` variable with the actual version of your application.

Returns:
  - None

Errors:

	If any error occurs during initialization or while starting the server, it will be logged
	and the application will terminate.

Environment Variables:

	The following environment variables must be set in an .env file for the function to work correctly:
	- PORT: The port number on which the HTTP server will listen.
	- DB_HOST: The hostname of the database server.
	- DB_PORT: The port number for the database connection.
	- DB_USER: The username for the database.
	- DB_PASS: The password for the database user.
	- DB_NAME: The name of the database.
	- MAX_IDLE: Maximum number of idle connections in the connection pool.
	- MAX_CONN: Maximum number of open connections in the connection pool.
	- MAX_LIFE_TIME: Maximum lifetime of a connection in seconds.

Example .env file:

	PORT=8080
	DB_HOST=localhost
	DB_PORT=5432
	DB_USER=myuser
	DB_PASS=mypassword
	DB_NAME=mydatabase
	MAX_IDLE=5
	MAX_CONN=10
	MAX_LIFE_TIME=300

Dependencies:

	This function depends on the `initEnv` function for loading environment variables and the
	`initializeDomainModule` function for setting up domain modules and routes.
*/
func RunService() {
	// Initialize database configuration and environment variables
	dbConfig, err := initEnv()
	if err != nil {
		log.Error().Msg("initEnv.err: " + err.Error())
		return
	}

	// Parse the maximum connection lifetime duration
	duration, err := time.ParseDuration(dbConfig.MaxLifeTime)
	if err != nil {
		log.Error().Msg("initEnv.duration.err: " + err.Error())
		return
	}

	// Create a connection to the database
	conn, err := database.NewPostgreSql(&dbConfig)
	if err != nil {
		log.Error().Msg("RunService.NewPostgreSql.err: " + err.Error())
		return
	}

	// Get the underlying SQL DB object
	sql, errSql := conn.DB()
	if errSql != nil {
		log.Error().Msg("RunService.NewPostgreSql.errSql: " + errSql.Error())
		return
	}

	// Configure the SQL connection pool
	go func() {
		sql.SetConnMaxLifetime(duration)
		sql.SetMaxOpenConns(dbConfig.MaxConn)
		sql.SetMaxIdleConns(dbConfig.MaxIdle)
	}()

	// Defer the closure of the SQL connection
	defer func() {
		errClose := sql.Close()
		if errClose != nil {
			log.Error().Msg(errClose.Error())
		}
	}()

	// Set up the application's timezone
	time.Local = time.FixedZone("Asia/Jakarta", 7*60*60)

	// Create a new Gin router
	r := gin.New()

	// Configure CORS support for the router
	r.Use(cors.New(cors.Config{
		AllowAllOrigins: false,
		AllowOrigins:    []string{"*"},
		AllowMethods:    []string{"POST", "DELETE", "GET", "OPTIONS", "PUT"},
		AllowHeaders: []string{"Origin", "Content-Type",
			"Authorization", "X-API-KEY",
			"X-REQUEST-ID", "X-CLIENT-ID", "X-TIMESTAMP", "ms"},
		ExposeHeaders:    []string{"Content-Length"},
		AllowCredentials: true,
		MaxAge:           120 * time.Second,
	}))

	// Configure logging for the application
	zerolog.TimeFieldFormat = zerolog.TimeFormatUnix
	zerolog.SetGlobalLevel(zerolog.DebugLevel)
	r.Use(logger.SetLogger(
		logger.WithLogger(func(_ *gin.Context, l zerolog.Logger) zerolog.Logger {
			return l.Output(gin.DefaultWriter).With().Logger()
		}),
	))

	// Enable Gin recovery middleware for error handling
	r.Use(gin.Recovery())

	// Create API and versioned API groups
	api := r.Group("/api")
	v1Group := api.Group("/v1")

	// TODO: Update version based on your application's versioning strategy
	version := "2023_08_09" // Update this date to match your actual version

	// Log the application version
	log.Info().Msg(fmt.Sprintf("Service Running version %s", version))

	// Initialize domain modules and routes
	initializeDomainModule(v1Group, conn)

	// Define the address to listen and serve
	addr := flag.String("port: ", ":"+dbConfig.Port, "Address to listen and serve")

	// Start the HTTP server
	err = r.Run(*addr)
	if err != nil {
		log.Error().Msg(err.Error())
	}
}
