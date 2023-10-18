/*
Package auth provides middleware for JWT (JSON Web Token) authentication in a Gin-based web application.

JwtAuth middleware checks the presence and validity of JWT tokens in the "Authorization" header of incoming HTTP requests. It ensures that requests with valid tokens proceed, while requests with missing, expired, or invalid tokens receive appropriate error responses.

Usage:
To use this middleware, simply attach it to routes or route groups where JWT authentication is required.

Example:

	router := gin.Default()

	// Apply JWT authentication middleware to a protected route
	router.GET("/protected", auth.JwtAuth, protectedHandler)

Notes:
- Ensure that you have imported the required packages, including the JWT service and JSON response utility.
- This middleware expects JWT tokens to be passed in the "Authorization" header with the "Bearer" prefix (e.g., "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...").
- Valid tokens allow requests to continue to the next handler, while invalid or missing tokens result in error responses and aborting the request.

Parameters:
  - c (*gin.Context): The Gin context representing the incoming HTTP request.

Middleware Behavior:
- Checks if the "Authorization" header contains the "Bearer" prefix. If not, it responds with an "Unauthorized" error.
- Extracts the token string from the header and attempts to parse it.
- If parsing succeeds, it verifies the token's validity, including expiration.
- If the token is invalid or expired, it responds with an appropriate error.
- If the token is valid, it allows the request to proceed to the next handler.

Error Responses:
- If the token is missing or not in the expected format, it responds with an "Unauthorized" error.
- If the token has expired, it responds with an "Unauthorized" error with a specific error code.
- If any other error occurs during token parsing or validation, it responds with an "Unauthorized" error, including the error message.

Security Note:
- Ensure that your application's JWT secret key and token validation settings are correctly configured for security.

Dependencies:
- This middleware depends on the "jwtService" and "shared/json" packages for JWT token parsing and error response generation.
*/
package auth

import (
	"strings"

	jwtService "stocktrack_server/services/jwt"
	"stocktrack_server/shared/constant"
	"stocktrack_server/shared/json"

	"github.com/gin-gonic/gin"
)

// JwtAuth is a middleware that provides JWT (JSON Web Token) authentication.
func JwtAuth(c *gin.Context) {
	authHeader := c.Request.Header.Get("Authorization")

	// Check for the presence of "Bearer" in the Authorization header
	if !strings.Contains(authHeader, "Bearer") {
		json.NewResponseUnauthorized(c, constant.ErrInvalidToken, constant.ServiceCodeAuth, constant.ErrCodeInvalidToken)
		c.Abort()
		return
	}

	// Extract the token string by removing the "Bearer " prefix
	tokenString := strings.Replace(authHeader, "Bearer ", "", -1)

	// Extract and parse the JWT token
	_, err := jwtService.ExtractAndParseJWT(tokenString)
	if err != nil {
		if strings.Contains(err.Error(), constant.ErrExpiredToken) {
			json.NewResponseUnauthorized(c, constant.ErrExpiredToken, constant.ServiceCodeAuth, constant.ErrCodeTokenExpired)
			c.Abort()
			return
		}
		json.NewResponseUnauthorized(c, err.Error(), constant.ServiceCodeAuth, constant.ErrCodeInvalidToken)
		c.Abort()
		return
	}

	// Allow the request to continue to the next handler
	c.Next()
}
