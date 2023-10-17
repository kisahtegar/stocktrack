/*
Package dbModel defines the data structure used to represent database configuration settings.

The dbModel package includes a single data structure: DBConfig. This structure is used to store
database connection configuration settings, such as host, port, username, password, database
name, connection pool settings, and maximum connection lifetime.

Structure:
  - DBConfig: This structure represents the configuration settings required for connecting to a
    database. It includes fields for host, database port, application port, username, password,
    database name, maximum idle connections, maximum open connections, and maximum connection lifetime.

Usage:
You can use the DBConfig structure to store and manage database connection configuration settings
in your application. These settings are typically required when establishing a connection to a database.

Example:

	// Create an instance of DBConfig with connection settings
	config := dbModel.DBConfig{
		Host:        "localhost",
		DbPort:      "5432",
		Port:        "8080",
		User:        "username",
		Pass:        "password",
		Database:    "mydb",
		MaxIdle:     10,
		MaxConn:     100,
		MaxLifeTime: "1h",
	}

	// Use the configuration settings to establish a database connection
	db, err := database.NewPostgreSql(&config)
	if err != nil {
		// Handle the error
	}

Structure:
- DBConfig:
  - Host (string): The hostname or IP address of the database server.
  - DbPort (string): The port number of the database server.
  - Port (string): The port on which the application is running.
  - User (string): The database user's username.
  - Pass (string): The database user's password.
  - Database (string): The name of the database to connect to.
  - MaxIdle (int): The maximum number of idle connections in the connection pool.
  - MaxConn (int): The maximum number of open connections in the connection pool.
  - MaxLifeTime (string): The maximum duration for which a connection can be reused (e.g., "1h" for one hour).

The DBConfig structure is designed to centralize and manage database configuration settings in your application.
*/
package dbModel

type (
	// DBConfig represents the configuration settings required for connecting to a database.
	DBConfig struct {
		Host        string
		DbPort      string
		Port        string
		User        string
		Pass        string
		Database    string
		MaxIdle     int
		MaxConn     int
		MaxLifeTime string
	}
)
