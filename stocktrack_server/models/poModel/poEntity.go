package poModel

import (
	"database/sql"
	"stocktrack_server/shared/entity"
	"time"
)

type (
	MsPo struct {
		PoId            int32          `gorm:"column:PoId"`
		SupplierId      int32          `gorm:"column:SupplierId"`
		PoCode          string         `gorm:"column:PoCode"`
		Amount          float32        `gorm:"column:Amount"`
		DiscountPercent float32        `gorm:"column:DiscountPercent"`
		Discount        float32        `gorm:"column:Discount"`
		TaxPercent      float32        `gorm:"column:TaxPercent"`
		Tax             float32        `gorm:"column:Tax"`
		IsActive        int32          `gorm:"column:IsActive"`
		CreatedDate     time.Time      `gorm:"column:CreatedDate"`
		CreatedBy       string         `gorm:"column:CreatedBy"`
		UpdatedDate     sql.NullTime   `gorm:"column:UpdatedDate"`
		UpdatedBy       sql.NullString `gorm:"column:UpdatedBy"`
	}
)

// TableName returns the table name for the "mspo (purchase order)" table.
func (MsPo) TableName() string {
	return entity.EntityMsPo
}
