package supplierModel

import (
	"database/sql"
	"stocktrack_server/shared/entity"
	"time"
)

type (
	MsSuppliers struct {
		SupplierId   int32          `gorm:"column:SupplierId"`
		SupplierCode string         `gorm:"column:SupplierCode"`
		SupplierName string         `gorm:"column:SupplierName"`
		Address      string         `gorm:"column:Address"`
		Contact      string         `gorm:"column:Contact"`
		IsActive     int32          `gorm:"column:IsActive"`
		CreatedDate  time.Time      `gorm:"column:CreatedDate"`
		CreatedBy    string         `gorm:"column:CreatedBy"`
		UpdatedDate  sql.NullTime   `gorm:"column:UpdatedDate"`
		UpdatedBy    sql.NullString `gorm:"column:UpdatedBy"`
	}
)

// TableName returns the table name for the "users" table.
func (MsSuppliers) TableName() string {
	return entity.EntityMsSuppliers
}
