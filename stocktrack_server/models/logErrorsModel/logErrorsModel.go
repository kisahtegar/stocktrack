/*
Package logErrorsModel defines the data structures used for working with error log data.

The logErrorsModel package includes two main data structures: LogErrors and DataLogErrors.
These structures represent error log records and the parameters required to insert error
log data.

Structures:

  - LogErrors: This structure represents a single error log record and includes fields such
    as Id, UserId, ModuleName, DescriptionError, and CreatedDate.

  - DataLogErrors: This structure represents the parameters required to insert error log data
    and includes fields such as UserId, ModuleName, and DescriptionError.

Usage:

	You can use these data structures in conjunction with a database or repository to manage
	and log error data.

Example:

	// Create an instance of DataLogErrors
	logData := logErrorsModel.DataLogErrors{
		UserId:           123,
		ModuleName:       "exampleModule",
		DescriptionError: "An error occurred.",
	}

	// Insert error log data using a repository
	err := repository.InsertLogErrors(&logData)
	if err != nil {
		// Handle the error
	}

Structures:
- LogErrors:
  - Id (uint64): The unique identifier for the error log record.
  - UserId (uint64): The user identifier associated with the error.
  - ModuleName (string): The name of the module where the error occurred.
  - DescriptionError (string): A description of the error.
  - CreatedDate (time.Time): The timestamp when the error log record was created.

- DataLogErrors:
  - UserId (uint64): The user identifier associated with the error.
  - ModuleName (string): The name of the module where the error occurred.
  - DescriptionError (string): A description of the error.

These data structures are designed to facilitate the management and logging of error information.
*/
package logErrorsModel

import "time"

type (
	// LogErrors represents a single error log record.
	LogErrors struct {
		Id               uint64    `gorm:"column:id"`
		UserId           uint64    `gorm:"column:user_id"`
		ModuleName       string    `gorm:"column:module_name"`
		DescriptionError string    `gorm:"column:description_error"`
		CreatedDate      time.Time `gorm:"column:created_date"`
	}

	// DataLogErrors represents the parameters required to insert error log data.
	DataLogErrors struct {
		UserId           uint64
		ModuleName       string
		DescriptionError string
	}
)
