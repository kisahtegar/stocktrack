package userUsecase

import (
	"stocktrack_server/models/jwtModel"
	"stocktrack_server/models/userModel"
	"stocktrack_server/modules/users"
	"stocktrack_server/services/global"
	jwtService "stocktrack_server/services/jwt"
	"time"

	"github.com/dgrijalva/jwt-go"
)

// userUsecase represents the user use case implementation.
type userUsecase struct {
	userRepo users.UserRepositories
}

// NewUserUsecase creates a new instance of the user use case.
func NewUserUsecase(userRepo users.UserRepositories) users.UserUsecases {
	return &userUsecase{
		userRepo: userRepo,
	}
}

// LoginUser handles the user login use case.
// It takes a LoginRequest 'in' as input, containing the user's login information.
// It returns a LoginResponse and an error. If successful, it generates an authentication token and a refresh token.
func (u *userUsecase) LoginUser(in *userModel.LoginRequest) (*userModel.LoginResponse, error) {
	// Generate a password hash for the user's input.
	myPassword := global.GeneratePassword(in.Username, in.Password)

	// Call the repository to retrieve the user by their username and password.
	user, err := u.userRepo.RetrieveUserByUsernamePassword(in.Username, myPassword)
	if err != nil {
		return nil, err
	}

	// If the user is not found, return nil as the response.
	if user == nil {
		return nil, nil
	}

	// Generate a JWT token for authentication.
	// Calculate the expiration time for the JWT token (1 hour from now).
	expiredToken := time.Now().Add(time.Hour * 1).Unix()

	// Create JWT claims containing user information and standard claims.
	jwtData := jwtModel.JwtClaims{
		UserID:     user.UserId,   // User's unique identifier.
		Username:   user.Username, // User's username.
		Fullname:   user.Fullname, // User's full name.
		Attributes: []string{},    // Additional user attributes (empty in this case).
		StandardClaims: jwt.StandardClaims{
			Issuer:    in.Username,  // Issuer of the token (typically the username).
			ExpiresAt: expiredToken, // Token will expire in 1 hour.
		},
	}

	// Generate the JWT token using the provided JWT claims.
	jwt, err := jwtService.GenerateTokenJwt(jwtData)
	if err != nil {
		return nil, err
	}

	// Generate a UUIDv4 for the refresh token.
	refreshToken, err := global.GenerateUUIDV4()
	if err != nil {
		return nil, err
	}

	// Set the expiration time for the refresh token to 1 day.
	expiredRefreshToken := time.Now().AddDate(0, 0, 1).Unix()

	// Save the authentication and refresh tokens to the database.
	if err = u.userRepo.SaveUserToken(&userModel.UserToken{
		UserId:              user.UserId,
		JwtToken:            jwt,
		RefreshToken:        refreshToken,
		ExpiredToken:        expiredToken,
		ExpiredRefreshToken: expiredRefreshToken,
		CreatedDate:         time.Now(),
	}); err != nil {
		return nil, err
	}

	// Return the JWT token and refresh token in the response.
	return &userModel.LoginResponse{
		Token:        jwt,
		RefreshToken: refreshToken,
	}, nil
}
