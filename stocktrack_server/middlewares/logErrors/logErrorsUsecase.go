/*
Package logErrors defines an interface for error logging.

The LogErrorsUsecase interface has one method for deciding whether an error should be logged based on specific criteria.

Usage:
To use this interface, create a struct that implements the CheckIsError method.

Example:

	type MyLogErrorsUsecase struct {
		// Implement methods here
	}

	func (u *MyLogErrorsUsecase) CheckIsError(err error, token, moduleName string) bool {
		// Custom logic to determine whether to log the error
	}

Interface Method:
  - CheckIsError(err error, token, moduleName string) bool:
    This method should be implemented to determine whether an error should be logged. It returns a boolean value (true or false) indicating whether the error should be logged.

Example Interface Implementation:
Here's an example of implementing the LogErrorsUsecase interface:

	type MyLogErrorsUsecase struct {
		// Implement methods here
	}

	// CheckIsError checks whether an error should be logged.
	func (u *MyLogErrorsUsecase) CheckIsError(err error, token, moduleName string) bool {
		// Implement custom logic here
		return true // Return true to log the error, or false to skip logging
	}

Implementations of this interface can provide their own custom logic to decide when and how to log errors.
*/
package logErrors

// LogErrorsUsecase is an interface for error logging that defines one method for decision-making.
type LogErrorsUsecase interface {
	// CheckIsError decides whether to log an error based on specific criteria.
	CheckIsError(err error, token, moduleName string) bool
}
