/*
Package database provides database connection functionality for the application.

This file contains the function to connect to a PostgreSQL database and returns a GORM database
instance. It ensures that only one database connection is established and reused throughout the
application's lifecycle.

Usage:
To create a database connection, call the `NewPostgreSql` function with a `dbModel.DBConfig`
struct containing the database configuration.

Example:

	dbConfig := dbModel.DBConfig{
		Host:     "localhost",
		DbPort:   "5432",
		User:     "myuser",
		Pass:     "mypassword",
		Database: "mydatabase",
	}
	db, err := NewPostgreSql(&dbConfig)
	if err != nil {
		log.Error().Msg("NewPostgreSql error: " + err.Error())
		return
	}

Notes:
  - Ensure that you have imported the required packages and set up the PostgreSQL driver (`github.com/lib/pq`).
  - The `NewPostgreSql` function establishes a database connection using the provided configuration
    and returns a GORM database instance.
  - The function is designed to create a single instance of the database connection and reuse it to prevent
    multiple connections.

Parameters:
  - option (*dbModel.DBConfig): A pointer to a `dbModel.DBConfig` struct containing the database configuration.

Returns:
  - db (*gorm.DB): A GORM database instance connected to the PostgreSQL database.
  - err (error): An error if any issues occur during database connection.

Example DBConfig:

	dbConfig := dbModel.DBConfig{
		Host:       "localhost",
		DbPort:     "5432",
		User:       "myuser",
		Pass:       "mypassword",
		Database:   "mydatabase",
		MaxIdle:    5,
		MaxConn:    10,
		MaxLifeTime: "300",
	}

Dependencies:
- The `gorm` package is used for creating the database connection.
- The PostgreSQL driver (`github.com/lib/pq`) is required for PostgreSQL database access.

Database Connection Reuse:
  - The function ensures that only one database connection is established and reused throughout the application by
    storing the connection in a global variable (`dbInstance`) and returning it if the connection already exists.

Security Note:
  - Avoid hardcoding sensitive database credentials in your code. Use environment variables or a secure configuration
    management approach to store and retrieve credentials securely.
*/
package database

import (
	"fmt"
	dbModel "stocktrack_server/models/dbmodel"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

var dbInstance *gorm.DB

// NewPostgreSql establishes a connection to the PostgreSQL database and returns a GORM database instance.
func NewPostgreSql(option *dbModel.DBConfig) (*gorm.DB, error) {
	if dbInstance != nil {
		return dbInstance, nil
	}

	// Connect to the database
	db, err := gorm.Open(postgres.Open(
		fmt.Sprintf(
			"host=%s user=%s password=%s dbname=%s port=%s sslmode=disable",
			option.Host, option.User, option.Pass, option.Database, option.DbPort,
		),
	), &gorm.Config{})

	if err != nil {
		return nil, err
	}

	dbInstance = db
	return dbInstance, nil
}
