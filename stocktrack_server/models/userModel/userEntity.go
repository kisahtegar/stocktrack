/*
Package userModel defines data structures for working with user-related data in the
application's database.

The userModel package includes two main data structures: User and UserToken. These
structures represent user information and user tokens used for authentication.

Structures:
- User: This structure represents user information retrieved from the "users" table.
  It includes fields such as UserId, Username, Password, Fullname, CreatedDate,
  CreatedBy, UpdatedDate, and UpdatedBy.

- UserToken: This structure represents user authentication tokens retrieved from the
  "usertokens" table. It includes fields such as UserId, JwtToken, RefreshToken,
  ExpiredToken, ExpiredRefreshToken, and CreatedDate.

Usage:
You can use these data structures to interact with user-related data in the application's
database. They provide a convenient way to work with user information and authentication tokens.

Structures:
- User:
  - UserId (int32): The unique identifier for the user.
  - Username (string): The username of the user.
  - Password (string): The hashed password of the user.
  - Fullname (string): The full name of the user.
  - CreatedDate (time.Time): The timestamp when the user record was created.
  - CreatedBy (string): The user or entity that created the user record.
  - UpdatedDate (sql.NullTime): The timestamp when the user record was last updated (nullable).
  - UpdatedBy (sql.NullString): The user or entity that last updated the user record (nullable).

- UserToken:
  - UserId (int32): The unique identifier of the user associated with the token.
  - JwtToken (string): The JSON Web Token (JWT) for authentication.
  - RefreshToken (string): The refresh token for authentication.
  - ExpiredToken (int64): The timestamp when the JWT token expires.
  - ExpiredRefreshToken (int64): The timestamp when the refresh token expires.
  - CreatedDate (time.Time): The timestamp when the token record was created.

These data structures are designed to simplify interactions with user-related data in the application's database.

*/

package userModel

import (
	"time"

	"stocktrack_server/shared/entity"
)

type (
	// User represents user information retrieved from the "users" table.
	User struct {
		UserId      int64     `gorm:"column:UserId"`
		Username    string    `gorm:"column:Username"`
		Password    string    `gorm:"column:Password"`
		Fullname    string    `gorm:"column:Fullname"`
		Email       string    `gorm:"column:Email"`
		CreatedDate time.Time `gorm:"column:CreatedDate"`
		CreatedBy   string    `gorm:"column:CreatedBy"`
		UpdatedDate time.Time `gorm:"column:UpdatedDate"`
		UpdatedBy   string    `gorm:"column:UpdatedBy"`
	}

	// UserToken represents user authentication tokens retrieved from the "usertokens" table.
	UserToken struct {
		UserId              int64     `gorm:"column:UserId"`
		JwtToken            string    `gorm:"column:JwtToken"`
		RefreshToken        string    `gorm:"column:RefreshToken"`
		ExpiredToken        int64     `gorm:"column:ExpiredToken"`
		ExpiredRefreshToken int64     `gorm:"column:ExpiredRefreshToken"`
		CreatedDate         time.Time `gorm:"column:CreatedDate"`
	}
)

// TableName returns the table name for the "users" table.
func (User) TableName() string {
	return entity.EntityUsers
}

// TableName returns the table name for the "usertokens" table.
func (UserToken) TableName() string {
	return entity.EntityUserTokens
}
