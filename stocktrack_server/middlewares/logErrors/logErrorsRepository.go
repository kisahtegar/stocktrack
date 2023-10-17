/*
Package logErrors defines an interface for error logging in a repository.

The LogErrorsRepository interface outlines a single method for inserting error log data.

Usage:
To use this interface, create a struct that implements the InsertLogErrors method.

Example:

	type MyLogErrorsRepository struct {
		// Implement methods here
	}

	func (r *MyLogErrorsRepository) InsertLogErrors(data *logErrorsModel.DataLogErrors) error {
		// Custom logic to insert error log data
	}

Interface Method:
  - InsertLogErrors(data *logErrorsModel.DataLogErrors) error:
    This method should be implemented to insert error log data into the repository. It takes error log data as input and returns an error if the insertion fails.

Example Interface Implementation:
Here's an example of implementing the LogErrorsRepository interface:

	type MyLogErrorsRepository struct {
		// Implement methods here
	}

	// InsertLogErrors inserts error log data.
	func (r *MyLogErrorsRepository) InsertLogErrors(data *logErrorsModel.DataLogErrors) error {
		// Implement custom logic to insert data
		return nil // Return nil for success, or an error on failure
	}

Implementations of this interface can provide their own custom logic for inserting error log data.
*/
package logErrors

import "stocktrack_server/models/logErrorsModel"

// LogErrorsRepository is an interface for inserting error log data into a repository.
type LogErrorsRepository interface {
	// InsertLogErrors inserts error log data.
	InsertLogErrors(data *logErrorsModel.DataLogErrors) error
}
