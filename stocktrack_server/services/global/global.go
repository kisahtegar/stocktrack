package global

import (
	"crypto/sha256"
	"encoding/base64"
	"encoding/hex"
	"errors"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

const baseModule = "global"

// generateSHA256 calculates the SHA-256 hash of the provided data.
//
// Parameters:
//   - data ([]byte): The data for which the SHA-256 hash needs to be calculated.
//
// Returns:
//   - (string): The SHA-256 hash of the input data, represented as a hexadecimal string.
func generateSHA256(data []byte) string {
	// Create a new SHA-256 hash instance.
	hash := sha256.New()

	// Write the provided data to the hash.
	hash.Write(data)

	// Sum computes the final hash and returns it as a byte slice.
	hashByte := hash.Sum(nil)

	// Encode the byte slice as a hexadecimal string.
	sha256 := hex.EncodeToString(hashByte)

	return sha256
}

// GeneratePassword generates a password hash based on the provided username and password.
//
// Parameters:
//   - username (string): The username to be combined with the password for hashing.
//   - pass (string): The password to be combined with the username for hashing.
//
// Returns:
//   - (string): The resulting password hash in lowercase.
func GeneratePassword(username, pass string) string {
	// Combine the username and password with a colon separator.
	myPassword := username + ":" + pass

	// Encode the combined string in base64.
	myPasswordBase64 := base64.StdEncoding.EncodeToString([]byte(myPassword))

	// Calculate the SHA-256 hash of the base64-encoded string.
	myPasswordHash := generateSHA256([]byte(myPasswordBase64))

	// Convert the hash to lowercase and return it.
	return strings.ToLower(myPasswordHash)
}

// GenerateUUIDV4 generates a new UUID (version 4) as a string.
//
// Returns:
//   - (string): The generated UUID v4 as a string.
//   - (error): An error if there was any issue generating the UUID.
func GenerateUUIDV4() (string, error) {
	moduleName := baseModule + ".GenerateUUIDV4"
	id, err := uuid.NewRandom()
	if err != nil {
		return "", errors.New(moduleName + ".error: " + err.Error())
	}
	return id.String(), nil
}

// GetToken extracts the authorization token from the "Authorization" header in a Gin context.
//
// Parameters:
//   - c (gin.Context): The Gin context from which the token should be extracted.
//
// Returns:
//   - (string): The extracted token string if found, empty string otherwise.
func GetToken(c *gin.Context) string {
	authHeader := c.GetHeader("Authorization")
	if !strings.Contains(authHeader, "Bearer") {
		return ""
	}
	tokenString := strings.Replace(authHeader, "Bearer ", "", -1)
	return tokenString
}
