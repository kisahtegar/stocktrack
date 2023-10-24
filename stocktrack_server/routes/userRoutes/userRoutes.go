package userRoutes

import (
	"stocktrack_server/middlewares/logErrors"
	"stocktrack_server/modules/users/userHandler"
	"stocktrack_server/modules/users/userRepository"
	"stocktrack_server/modules/users/userUsecase"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

// UserRoutes registers user-related routes and their corresponding handlers.
// It takes a Gin RouterGroup 'v1Group' for versioned API routes, a GORM database 'conn' for data access,
// and a LogErrorsUsecase 'logUC' for handling error logging.
func UserRoutes(v1Group *gin.RouterGroup, conn *gorm.DB, logUC logErrors.LogErrorsUsecase) {
	// Create a new user repository using the provided database connection.
	userRepo := userRepository.NewUserRepository(conn)

	// Create a new user usecase with the user repository.
	userUC := userUsecase.NewUserUsecase(userRepo)

	// Register user routes and handlers using the user usecase and error logging usecase.
	userHandler.NewUserHandler(v1Group, userUC, logUC)
}
