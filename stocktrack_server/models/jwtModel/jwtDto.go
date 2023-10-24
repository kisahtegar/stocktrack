/*
Package jwtModel defines the data structure used for working with JSON Web Tokens (JWT) claims.

The jwtModel package includes a single data structure: JwtClaims. This structure is used to
represent JWT claims, including standard claims from the jwt-go library and custom claims such
as UserID, Username, Fullname, and Attributes.

Structure:
  - JwtClaims: This structure represents the claims included in a JWT. It extends the jwt.StandardClaims
    structure from the jwt-go library and adds custom claims specific to your application.

Usage:
You can use the JwtClaims structure to encode and decode JWT tokens in your application. It
allows you to store custom user-related information securely within the token.

Example:

	// Create a JwtClaims instance with custom claims
	claims := jwtModel.JwtClaims{
		UserID:     123,
		Username:   "john_doe",
		Fullname:   "John Doe",
		Attributes: []string{"admin", "user"},
	}

	// Encode the claims into a JWT token
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	tokenString, err := token.SignedString([]byte("your-secret-key"))
	if err != nil {
		// Handle the error
	}

	// Decode the JWT token and extract the claims
	parsedToken, err := jwt.ParseWithClaims(tokenString, &jwtModel.JwtClaims{}, func(token *jwt.Token) (interface{}, error) {
		return []byte("your-secret-key"), nil
	})
	if err != nil {
		// Handle the error
	}
	claimsFromToken := parsedToken.Claims.(*jwtModel.JwtClaims)

Structure:
- JwtClaims:
  - StandardClaims (jwt.StandardClaims): Standard JWT claims like issuer, subject, and expiration.
  - UserID (int32): Custom claim representing the user's ID.
  - Username (string): Custom claim representing the user's username.
  - Fullname (string): Custom claim representing the user's full name.
  - Attributes ([]string): Custom claim representing additional user attributes or roles.

The JwtClaims structure is designed to facilitate the encoding and decoding of JWT tokens with custom claims specific to your application.
*/
package jwtModel

import "github.com/dgrijalva/jwt-go"

type (
	JwtClaims struct {
		jwt.StandardClaims
		UserID     int64    `json:"user_id"`
		Username   string   `json:"username"`
		Fullname   string   `json:"fullname"`
		Attributes []string `json:"attributes"`
	}
)
