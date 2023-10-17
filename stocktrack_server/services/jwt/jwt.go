package jwt

import (
	"errors"
	"fmt"
	"os"
	"stocktrack_server/models/jwtModel"

	"github.com/dgrijalva/jwt-go"
	"github.com/rs/zerolog/log"
)

// baseModule is the base module name used for logging and error messages.
const baseModule = "jwt"

// ExtractAndParseJWT extracts and parses JWT claims from the given JWT token string.
// It is responsible for decoding and verifying the authenticity of the JWT.
//
// Parameters:
//   - tokenString: The JWT token string to be parsed and validated.
//
// Returns:
//   - (*jwtModel.JwtClaims): A pointer to the parsed JWT claims if successful.
//   - (error): An error describing any issues encountered during parsing or validation.
func ExtractAndParseJWT(tokenString string) (*jwtModel.JwtClaims, error) {
	// Define the module name for logging purposes.
	moduleName := baseModule + ".ExtractAndParseJWT"

	// Create a new JwtClaims structure to hold the parsed JWT claims.
	claims := &jwtModel.JwtClaims{}

	// Retrieve the JWT secret key from the environment variables.
	secretKey := os.Getenv("JWT_KEY")

	// Parse the JWT token with the provided secret key and custom claims.
	token, err := jwt.ParseWithClaims(tokenString, claims, func(token *jwt.Token) (interface{}, error) {
		return []byte(secretKey), nil
	})

	// Check for parsing errors.
	if err != nil {
		log.Error().Msg(err.Error())
		return nil, errors.New(moduleName + ".error: " + err.Error())
	}

	// Check if the token is valid.
	if !token.Valid {
		return nil, errors.New(moduleName + ".error: " + fmt.Sprintf("token %s is invalid", tokenString))
	}

	// Return the parsed JWT claims and no errors if successful.
	return claims, nil
}

// GenerateTokenJwt generates a JSON Web Token (JWT) using the provided claims data.
// It creates a signed JWT token with the specified claims and returns it, or an error
// if the token generation process encounters any issues.
//
// Parameters:
//   - jwtData (jwtModel.JwtClaims): The JWT claims data to be included in the token.
//
// Returns:
//   - (string): The generated and signed JWT token as a string if successful.
//   - (error): An error describing any issues encountered during token generation.
func GenerateTokenJwt(jwtData jwtModel.JwtClaims) (string, error) {
	// Define the module name for logging purposes.
	moduleName := baseModule + ".GenerateTokenJwt"

	// Retrieve the JWT secret key from the environment variables.
	secretKey := os.Getenv("JWT_KEY")

	// Create a new JWT token with the specified signing method and claims data.
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, jwtData)

	// Sign the JWT token using the secret key to produce the final signed token.
	signedToken, err := token.SignedString([]byte(secretKey))

	// Check for errors during token signing.
	if err != nil {
		return "", errors.New(moduleName + ".error: " + err.Error())
	}

	// Return the generated and signed JWT token as a string, with no errors if successful.
	return signedToken, nil
}
