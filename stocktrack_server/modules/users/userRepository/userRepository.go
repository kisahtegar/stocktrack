// Package userRepository provides implementations for user-related data repository operations.
// It includes methods for user registration, retrieval by username and password, and user token management.
package userRepository

import (
	"errors"
	"stocktrack_server/models/userModel"
	"stocktrack_server/modules/users"
	"stocktrack_server/shared/entity"

	"gorm.io/gorm"
)

// baseModule is a constant representing the base module name for this repository.
const baseModule = "userRepository"

// userRepository is the implementation of the UserRepositories interface.
type userRepository struct {
	conn *gorm.DB
}

// NewUserRepository creates a new userRepository instance with the given database connection.
func NewUserRepository(conn *gorm.DB) users.UserRepositories {
	return &userRepository{
		conn: conn,
	}
}

// RetrieveUserByUsernamePassword retrieves a user record from the database by providing the username and password.
// It returns the user model if found or nil if the user is not found.
// If an error occurs during the database query, it returns an error.
func (u *userRepository) RetrieveUserByUsernamePassword(username, password string) (*userModel.User, error) {
	// moduleName is a constant representing the base module name for this function.
	moduleName := baseModule + ".RetrieveUserByUsernamePassword"

	// Initialize a variable to store the retrieved user.
	var user userModel.User

	// Query the database to find a user with the given username and password.
	err := u.conn.Select("\"UserId\", \"Username\", \"Fullname\"").
		Where("\"Username\" = ? AND \"Password\" = ?", username, password).
		First(&user).
		Error

	// Check if the error indicates that no record was found.
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, nil
	}

	// Check if there was any other error during the database query.
	if err != nil {
		return nil, errors.New(moduleName + ".error: " + err.Error())
	}

	// Return the retrieved user model.
	return &user, nil
}

// SaveUserToken saves a user's authentication token in the database for future use.
// It takes a UserToken object 'in' as input, containing the user's token information.
// If the token is successfully saved, it returns nil. If an error occurs during the
// database operation, it returns an error with details.
func (u *userRepository) SaveUserToken(in *userModel.UserToken) error {
	// moduleName is a constant representing the base module name for this function.
	moduleName := baseModule + ".SaveUserToken"

	// Attempt to create a new record in the 'UserTokens' table with the provided token information.
	err := u.conn.Table(entity.EntityUserTokens).Create(in).Error

	// Check if there was an error during the database operation.
	if err != nil {
		// Return an error with details if the operation failed.
		return errors.New(moduleName + ".error: " + err.Error())
	}

	// Return nil to indicate that the token was successfully saved.
	return nil
}
