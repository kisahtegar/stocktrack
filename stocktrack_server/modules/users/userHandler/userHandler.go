package userHandler

import (
	"stocktrack_server/middlewares/logErrors"
	"stocktrack_server/models/userModel"
	"stocktrack_server/modules/users"
	"stocktrack_server/services/validation"
	"stocktrack_server/shared/constant"
	"stocktrack_server/shared/json"

	"github.com/gin-gonic/gin"
)

// userhandler represents the handler for user-related operations.
type userhandler struct {
	userUsecase users.UserUsecases
	logUsecase  logErrors.LogErrorsUsecase
}

// NewUserHandler creates a new instance of userhandler and sets up user-related routes.
func NewUserHandler(v1Group *gin.RouterGroup, userUsecase users.UserUsecases, logUC logErrors.LogErrorsUsecase) {
	handler := userhandler{
		userUsecase: userUsecase,
		logUsecase:  logUC,
	}
	userGroup := v1Group.Group("/user")
	// userGroup.Use(auth.BasicAuth)
	{
		userGroup.POST("/login", handler.loginUser)
	}
}

// loginUser handles the user login operation.
func (u *userhandler) loginUser(c *gin.Context) {
	// Parse the incoming JSON request into a LoginRequest struct.
	var in userModel.LoginRequest
	if err := c.ShouldBindJSON(&in); err != nil {
		// Handle JSON validation errors.
		validations := validation.GetValidationError(err)
		if len(validations) > 0 {
			json.NewResponseBadRequest(c, validations, constant.BadRequestMsg, constant.ServiceCodeUser, constant.SuccessCode)
			return
		}

		json.NewResponseError(c, err.Error(), constant.ServiceCodeUser, constant.ErrCodeGeneralError)
		return
	}

	// Attempt to login the user using the provided credentials.
	result, err := u.userUsecase.LoginUser(&in)

	// Check if an error occurred during the login process.
	isError := u.logUsecase.CheckIsError(err, "", c.HandlerName())
	if isError {
		json.NewResponseError(c, err.Error(), constant.ServiceCodeUser, constant.ErrCodeGeneralError)
		return
	}

	// If the user is not found, return a BadRequest response with an appropriate message.
	if result == nil {
		json.NewResponseBadRequest(c, nil, constant.UserNotFoundMsg, constant.ServiceCodeUser, constant.ErrCodeUserNotFound)
		return
	}

	// Respond with a successful login response, including the authentication token.
	json.NewResponseSuccess(c, result, constant.SuccessMessage, constant.ServiceCodeUser, constant.SuccessCode)
}
