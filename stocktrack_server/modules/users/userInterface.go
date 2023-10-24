package users

import "stocktrack_server/models/userModel"

type (
	UserRepositories interface {
		RetrieveUserByUsernamePassword(username, password string) (*userModel.User, error)
		SaveUserToken(in *userModel.UserToken) error
	}

	UserUsecases interface {
		LoginUser(in *userModel.LoginRequest) (*userModel.LoginResponse, error)
	}
)
