/*
Package json provides utility functions for generating JSON responses in a structured format
for the application.

This package includes several response structures and functions for handling success, error,
bad request, unauthorized, and pagination responses in JSON format.

JSON Response Structures:
1. jsonResponse: Represents a standard JSON response for success.
2. jsonErrorResponse: Represents a JSON response for errors.
3. ValidationField: Represents a field validation error in a bad request response.
4. jsonBadRequestResponse: Represents a JSON response for bad requests with validation errors.
5. PaginationResponse: Represents pagination information in JSON responses.
6. JsonPaginationResponse: Represents a JSON response with pagination data.

Response Functions:
- NewResponseSuccess: Generates a successful JSON response with data.
- NewResponseBadRequest: Generates a JSON response for bad requests with validation errors.
- NewResponseError: Generates a JSON response for internal server errors.
- NewResponseUnauthorized: Generates a JSON response for unauthorized access.
- NewResponsePagination: Generates a JSON response with pagination data.
- NewResponse: Generates a JSON response with a custom status code.

Usage:
You can use these functions to send structured JSON responses from your API endpoints, making it easier to handle different types of responses, including success, errors, validation issues, and paginated data.

Example:
	// Respond with a successful JSON response.
	json.NewResponseSuccess(c, resultData, "Request successful", "AuthService", "001")

Note:
- These functions help maintain consistency in response formatting across the application.
- Response codes are prefixed with a combination of HTTP status codes, service codes, and error codes for easy identification.

*/

package json

import (
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

type (
	// Standard JSON response for success.
	jsonResponse struct {
		Code    string      `json:"code"`
		Message string      `json:"message"`
		Data    interface{} `json:"data,omitempty"`
	}

	// JSON response for errors.
	jsonErrorResponse struct {
		Code    string `json:"code"`
		Message string `json:"message"`
		Error   string `json:"error,omitempty"`
	}

	// ValidationField represents a field validation error in a bad request response.
	ValidationField struct {
		FieldName string `json:"field"`
		Message   string `json:"message"`
	}

	// JSON response for bad requests with validation errors.
	jsonBadRequestResponse struct {
		Code             string            `json:"code"`
		Message          string            `json:"message"`
		ErrorDescription []ValidationField `json:"error_description,omitempty"`
	}

	// Represents pagination information in JSON responses.
	PaginationResponse struct {
		TotalData int64 `json:"total_data"`
		TotalPage int32 `json:"total_page"`
		Page      int32 `json:"page"`
		Limit     int16 `json:"limit"`
	}

	// Represents a JSON response with pagination data.
	JsonPaginationResponse struct {
		Code           string             `json:"code"`
		Message        string             `json:"message"`
		Data           interface{}        `json:"data,omitempty"`
		PaginationData PaginationResponse `json:"pagination_data"`
	}
)

// Generates a successful JSON response with data.
func NewResponseSuccess(c *gin.Context, result interface{}, message, serviceCode, responseCode string) {
	c.JSON(http.StatusOK, jsonResponse{
		Code: "200",
		// Code:    "200" + serviceCode + responseCode,
		Message: message,
		Data:    result,
	})
}

// Generates a JSON response for bad requests with validation errors.
func NewResponseBadRequest(c *gin.Context, validationField []ValidationField, message, serviceCode, errorCode string) {
	c.JSON(http.StatusBadRequest, jsonBadRequestResponse{
		Code: "400",
		// Code:             "400" + serviceCode + errorCode,
		Message:          message,
		ErrorDescription: validationField,
	})
}

// Generates a JSON response for internal server errors.
func NewResponseError(c *gin.Context, err, serviceCode, errorCode string) {
	c.JSON(http.StatusInternalServerError, jsonErrorResponse{
		Code: "500",
		// Code:    "500" + serviceCode + errorCode,
		Message: "internal server error",
		Error:   err,
	})
}

// Generates a JSON response for unauthorized access.
func NewResponseUnauthorized(c *gin.Context, message, serviceCode, errorCode string) {
	c.JSON(http.StatusUnauthorized, jsonResponse{
		Code: "401",
		// Code:    "401" + serviceCode + errorCode,
		Message: message,
	})
}

// Generates a JSON response with pagination data.
func NewResponsePagination(c *gin.Context, result interface{}, message, serviceCode, responseCode string, paginationData *PaginationResponse) {
	c.JSON(http.StatusOK, JsonPaginationResponse{
		Code: "200",
		// Code:           "200" + serviceCode + responseCode,
		Message:        message,
		Data:           result,
		PaginationData: *paginationData,
	})
}

// Generates a JSON response with a custom status code.
func NewResponse(c *gin.Context, message, serviceCode, responseCode string, statusCode int) {
	myStatusCode := strconv.Itoa(statusCode)
	c.JSON(statusCode, jsonResponse{
		Code:    myStatusCode + serviceCode + responseCode,
		Message: message,
	})
}
