package itemModel

import (
	"database/sql"
	"stocktrack_server/shared/entity"
	"time"
)

type (
	MsItems struct {
		ItemId      int32          `gorm:"column:ItemId"`
		SupplierId  int32          `gorm:"column:SupplierId"`
		ItemCode    string         `gorm:"column:ItemCode"`
		ItemName    string         `gorm:"column:ItemName"`
		Description string         `gorm:"column:Description"`
		Cost        string         `gorm:"column:Cost"`
		IsActive    int32          `gorm:"column:IsActive"`
		CreatedDate time.Time      `gorm:"column:CreatedDate"`
		CreatedBy   string         `gorm:"column:CreatedBy"`
		UpdatedDate sql.NullTime   `gorm:"column:UpdatedDate"`
		UpdatedBy   sql.NullString `gorm:"column:UpdatedBy"`
	}
)

// TableName returns the table name for the "users" table.
func (MsItems) TableName() string {
	return entity.EntityMsItems
}
