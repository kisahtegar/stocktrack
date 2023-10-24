package validation

import (
	"fmt"
	"stocktrack_server/shared/json"
	"strings"

	"github.com/go-playground/validator/v10"
	"github.com/rs/zerolog/log"
	"github.com/stoewer/go-strcase"
)

// GetValidationError extracts and formats validation errors from the provided error.
// It parses validation errors from the validator package and transforms them into a
// slice of json.ValidationField objects containing field names and error messages.
//
// Parameters:
//   - err (error): The error containing validation errors to be processed.
//
// Returns:
//   - ([]json.ValidationField): A slice of json.ValidationField objects representing
//     field names and their corresponding error messages.
func GetValidationError(err error) []json.ValidationField {
	var validationFields []json.ValidationField

	// Check if the error is a validation error.
	if ve, ok := err.(validator.ValidationErrors); ok {
		// Log debug information for the validation errors.
		log.Debug().Msg(fmt.Sprintf("ve: %v", ve))

		// Iterate through each validation error and convert them into json.ValidationField.
		for _, validationError := range ve {
			// Log debug information for each validation error.
			log.Debug().Msg(fmt.Sprintf("validationError: %v", validationError))

			// Convert the validation field name to the desired format.
			myField := convertFieldRequired(validationError.Namespace())

			// Format the error message based on the error's tag.
			validationFields = append(validationFields, json.ValidationField{
				FieldName: myField,
				Message:   formatMessage(validationError),
			})
		}
	}

	// Log debug information for the final validation fields.
	log.Debug().Msg(fmt.Sprintf("validationFields: %v", validationFields))

	// Return the formatted validation fields.
	return validationFields
}

// convertFieldRequired converts a validation field name to snake_case format.
//
// This function takes a field name string and transforms it into snake_case format,
// making it suitable for consistent naming conventions in data validation and error handling.
//
// Parameters:
//   - myValue (string): The field name to be converted.
//
// Returns:
//   - (string): The field name in snake_case format.
func convertFieldRequired(myValue string) string {
	// Split the field name into segments based on dot (.) separator.
	fieldSegments := strings.Split(myValue, ".")

	myField := ""
	length := len(fieldSegments)
	i := 1

	// Iterate through the field segments to construct the snake_case field name.
	for _, val := range fieldSegments {
		// Skip the first segment (e.g., omit "field" in "field.subfield").
		if i == 1 {
			i++
			continue
		}

		// If it's the last segment, add it in snake_case format.
		if i == length {
			myField += strcase.SnakeCase(val)
			break
		}

		// For intermediate segments, add in lowerCamelCase format with a slash (/) separator.
		myField += strcase.LowerCamelCase(val) + `/`
		i++
	}

	return myField
}

// formatMessage formats a validation error message based on the error's tag.
//
// This function takes a validator.FieldError as input, inspects its tag value,
// and generates a formatted error message based on common validation tags.
//
// Parameters:
//   - err (validator.FieldError): The validation error to be formatted.
//
// Returns:
//   - (string): The formatted error message.
func formatMessage(err validator.FieldError) string {
	var message string

	// Switch statement to handle different validation error tags.
	switch err.Tag() {
	case "required":
		message = "This field is required." // A simple "required" error message.
	case "number":
		message = "Must be a valid number." // An error message for invalid numbers.
	case "email":
		message = "Invalid email format." // An error message for invalid email addresses.
	}

	return message
}
