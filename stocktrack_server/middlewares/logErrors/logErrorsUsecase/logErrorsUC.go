/*
Package logErrorsUsecase provides a use case implementation for handling and logging errors.

The logErrorsUsecase struct in this package implements the LogErrorsUsecase interface. It is
responsible for checking whether an error should be logged based on specific criteria and
performing the error logging process.

Usage:
To use this implementation, create a logErrorsUsecase object by calling the NewLogErrorsUsecase
function and passing a LogErrorsRepository instance. The created object can then be used to
check and log errors.

Example:

	// Create a logErrorsUsecase instance
	usecase := NewLogErrorsUsecase(repository)

	// Check an error and log it if needed
	if usecase.CheckIsError(err, token, moduleName) {
		// Error is logged or handled accordingly
	}

Struct:
- logErrorsUsecase: This struct represents the use case for handling and logging errors. It
includes a logErrors.LogErrorsRepository instance.

Methods:
  - CheckIsError(err error, token, moduleName string) bool:
    This method checks whether an error should be logged based on specific criteria. It takes
    an error, a JWT token (user identifier), and the name of the module where the error occurred
    as input. It returns a boolean value (true or false) indicating whether the error should
    be logged.

Example Use Case:
Here's an example of how to use the logErrorsUsecase to check and potentially log errors:

	// Create a logErrorsUsecase instance
	usecase := NewLogErrorsUsecase(repository)

	// Check an error and log it if needed
	if usecase.CheckIsError(err, token, moduleName) {
		// Error is logged or handled accordingly
	}

Dependencies:
  - This package depends on the "jwtService" package for JWT token handling.
  - It also uses models and entities defined in other packages, such as "logErrorsModel" and
    "zerolog/log."
*/
package logErrorsUsecase

import (
	"stocktrack_server/middlewares/logErrors"
	"stocktrack_server/models/logErrorsModel"
	jwtService "stocktrack_server/services/jwt"
	"strconv"

	"github.com/rs/zerolog/log"
)

// logErrorsUsecase is an implementation of the LogErrorsUsecase interface for handling and logging errors.
type logErrorsUsecase struct {
	logErrorsRepository logErrors.LogErrorsRepository
}

// NewLogErrorsUsecase creates a new logErrorsUsecase object for handling and logging errors.
func NewLogErrorsUsecase(logErrorsRepo logErrors.LogErrorsRepository) logErrors.LogErrorsUsecase {
	return &logErrorsUsecase{logErrorsRepository: logErrorsRepo}
}

// CheckIsError checks whether an error should be logged based on specific criteria.
func (logErrorsUC *logErrorsUsecase) CheckIsError(err error, token, moduleName string) bool {
	if err != nil {
		// Check if the error message is numeric
		_, errNumeric := strconv.Atoi(err.Error())
		if errNumeric != nil {
			var myUserId uint64

			// Check JWT token
			if token != "" {
				parseToken, errParseToken := jwtService.ExtractAndParseJWT(token)
				if errParseToken != nil {
					log.Error().Msg(errParseToken.Error())
					return false
				}
				myUserId = uint64(parseToken.UserID)
			}

			// Log the error and insert it into the repository/model
			go func(userId uint64, module, descError string) {
				log.Error().Msg(descError)
				logErrorsData := logErrorsModel.DataLogErrors{
					UserId:           userId,
					ModuleName:       module,
					DescriptionError: descError,
				}

				errInsertLog := logErrorsUC.logErrorsRepository.InsertLogErrors(&logErrorsData)
				if errInsertLog != nil {
					log.Error().Msg(errInsertLog.Error())
				}
			}(myUserId, moduleName, err.Error())

			// Indicate that the error should be logged
			return true
		}
		return false
	}
	return false
}
