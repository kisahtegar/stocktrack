/*
Package sharedGlobal provides utility functions and types for handling global shared data and
pagination in the application.

This package defines structures for handling pagination data and requests. It also includes a
function for creating a `PaginationData` structure from a `PaginationRequest`.

Types:
1. PaginationData: Represents pagination data including offset, limit, page, and search parameters.
2. PaginationRequest: Represents a request for pagination with offset, limit, and search parameters.

Functions:
- NewPaginationData: Creates a `PaginationData` structure based on the input `PaginationRequest`.
  It handles the conversion of offset and limit strings to integers and calculates the appropriate
  page number.

Usage:
You can use the `PaginationData` structure to manage pagination parameters in your application.
The `NewPaginationData` function simplifies the creation of pagination data from request parameters.

Example:
	// Create a PaginationRequest from request parameters.
	paginationRequest := sharedGlobal.PaginationRequest{
		Offset: "1",
		Limit:  "10",
		Search: "example",
	}

	// Generate a PaginationData structure for use in database queries.
	paginationData := sharedGlobal.NewPaginationData(paginationRequest)

Note:
- This package helps manage pagination-related data and simplifies the conversion of request
  parameters into usable pagination data.
*/

package sharedGlobal

import "strconv"

type (
	// PaginationData represents pagination data including offset, limit, page, and search parameters.
	PaginationData struct {
		Offset int
		Limit  int
		Page   int
		Search string
	}

	// PaginationRequest represents a request for pagination with offset, limit, and search parameters.
	PaginationRequest struct {
		Offset string
		Limit  string
		Search string
	}
)

// [NewPaginationData] creates a PaginationData structure based on the input PaginationRequest.
//
// It takes a PaginationRequest and converts its offset and limit fields from strings to integers.
// If conversion fails, it defaults to offset=0 and limit=10.
//
// The function calculates the appropriate page number based on offset and limit values.
//
// Parameters:
//
//	in PaginationRequest: The input request containing offset, limit, and search parameters.
//
// Returns:
//
//	PaginationData: A structure representing pagination data, including offset, limit, page, and search parameters.
//
// Example:
//
//	paginationRequest := sharedGlobal.PaginationRequest{
//	  Offset: "1",
//	  Limit:  "10",
//	  Search: "example",
//	}
//	paginationData := sharedGlobal.NewPaginationData(paginationRequest)
func NewPaginationData(in PaginationRequest) PaginationData {
	myOffset, err := strconv.Atoi(in.Offset)
	if err != nil {
		// If offset cannot be converted to an integer, default to 0.
		myOffset = 0
	}
	myLimit, err := strconv.Atoi(in.Limit)
	if err != nil {
		// If limit cannot be converted to an integer, default to 10.
		myLimit = 10
	}
	if myOffset > 0 {
		// Calculate the adjusted offset based on page number.
		myOffset = (myOffset - 1) * myLimit
	}
	return PaginationData{
		Offset: myOffset,
		Limit:  myLimit,
		// Calculate the page number based on adjusted offset and limit.
		Page:   myOffset/myLimit + 1,
		Search: in.Search,
	}
}
