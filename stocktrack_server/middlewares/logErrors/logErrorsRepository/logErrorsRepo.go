/*
Package logErrorsRepository provides an implementation of the LogErrorsRepository interface for
handling error log data in a SQL database.

The sqlRepository struct in this package implements the methods defined in the LogErrorsRepository
interface. It is responsible for inserting error log data into the SQL database.

Usage:
To use this implementation, create a sqlRepository object by calling the NewLogErrorsRepository
function and passing a *gorm.DB instance. The created object can then be used to insert error
log data into the database.

Example:

	// Create a sqlRepository instance
	repo := NewLogErrorsRepository(db)

	// Insert error log data
	err := repo.InsertLogErrors(data)
	if err != nil {
		// Handle the error
	}

Struct:
  - sqlRepository: This struct represents the SQL database repository for error log data. It includes
    a connection to a *gorm.DB instance.

Methods:
  - InsertLogErrors(data *logErrorsModel.DataLogErrors) error:
    This method inserts error log data into the SQL database. It takes error log data as input and
    returns an error if the insertion fails.

Example Repository Usage:
Here's an example of how to use the sqlRepository to insert error log data into a SQL database:

	// Create a sqlRepository instance
	repo := NewLogErrorsRepository(db)

	// Error log data to insert
	data := &logErrorsModel.DataLogErrors{
		UserId:           123,
		ModuleName:       "exampleModule",
		DescriptionError: "An error occurred.",
	}

	// Insert error log data
	err := repo.InsertLogErrors(data)
	if err != nil {
		// Handle the error
	}

Dependencies:
- This package depends on the "gorm" package for database interaction.
- It also uses models and entities defined in other packages, such as "logErrorsModel" and "entity."
*/
package logErrorsRepository

import (
	"errors"
	"stocktrack_server/middlewares/logErrors"
	"stocktrack_server/models/logErrorsModel"
	"stocktrack_server/shared/entity"
	"time"

	"gorm.io/gorm"
)

// sqlRepository is an implementation of the LogErrorsRepository interface for handling error log data in a SQL database.
type sqlRepository struct {
	Conn *gorm.DB
}

// NewLogErrorsRepository creates a new sqlRepository object for handling error log data in a SQL database.
func NewLogErrorsRepository(Conn *gorm.DB) logErrors.LogErrorsRepository {
	return &sqlRepository{Conn: Conn}
}

// InsertLogErrors inserts error log data into the SQL database.
func (db *sqlRepository) InsertLogErrors(data *logErrorsModel.DataLogErrors) error {
	logErrors := logErrorsModel.LogErrors{
		UserId:           data.UserId,
		ModuleName:       data.ModuleName,
		DescriptionError: data.DescriptionError,
		CreatedDate:      time.Now(),
	}

	err := db.Conn.Table(entity.EntityLogErrors).Select("UserId", "ModuleName", "DescError", "CreatedDate").Create(&logErrors).Error
	if err != nil {
		return errors.New("LogErrorsRepo.InsertLogErrors Err : " + err.Error())
	}

	return nil
}
