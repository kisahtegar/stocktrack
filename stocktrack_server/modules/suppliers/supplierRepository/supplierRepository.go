package supplierRepository

import (
	"errors"
	"stocktrack_server/models/supplierModel"
	"stocktrack_server/modules/suppliers"
	"stocktrack_server/shared/constant"
	"stocktrack_server/shared/entity"
	sharedGlobal "stocktrack_server/shared/global"

	"gorm.io/gorm"
)

const baseModule = "supplierRepository"

type supplierRepository struct {
	conn *gorm.DB
}

func NewSupplierRepository(conn *gorm.DB) suppliers.SupplierRepositories {
	return &supplierRepository{
		conn: conn,
	}
}

// Implement RetrieveAllSupplier for repository.
func (s *supplierRepository) RetrieveAllSupplier(paginationData sharedGlobal.PaginationData) ([]supplierModel.MsSuppliers, int64, error) {
	var (
		suppliers []supplierModel.MsSuppliers
		count     int64
		err       error
	)

	if paginationData.Search != "" {

		err = s.conn.Table(entity.EntityMsSuppliers).
			Where("(concat(SupplierCode,SupplierName) LIKE ?)", "%"+paginationData.Search+"%").
			Limit(paginationData.Limit).
			Offset(paginationData.Offset).
			Find(&suppliers).
			Offset(-1).
			Limit(-1).
			Count(&count).Error
	} else {

		err = s.conn.Table(entity.EntityMsSuppliers).
			Limit(paginationData.Limit).
			Offset(paginationData.Offset).
			Find(&suppliers).
			Offset(-1).
			Limit(-1).
			Count(&count).Error
	}

	if err != nil {
		return nil, 0, errors.New(baseModule + ".RetrieveAllSupplier.error: " + err.Error())
	}

	return suppliers, count, nil
}

// Implement CreateSupplier for repository.
func (s *supplierRepository) CreateSupplier(supplierRequest supplierModel.MsSuppliers) error {
	moduleName := baseModule + ".CreateSupplier"

	// Check if SupplierCode already exists.
	var existingSupplier supplierModel.MsSuppliers

	err := s.conn.Table(entity.EntityMsSuppliers).
		Where("\"SupplierCode\" = ?", supplierRequest.SupplierCode).
		First(&existingSupplier).Error

	if err == nil {
		// If record with the same SupplierCode exists, return an error
		return errors.New(moduleName + ".error: SupplierCode = " + supplierRequest.SupplierCode + " already exists")
	} else if !errors.Is(err, gorm.ErrRecordNotFound) {
		// If any other error while database query
		return errors.New(moduleName + ".error: " + err.Error())
	}

	// If SupplierCode doesnt exist RecordNotFound and create new one.
	err = s.conn.Table(entity.EntityMsSuppliers).
		Select("SupplierCode", "SupplierName", "Address", "Contact", "IsActive", "CreatedDate", "CreatedBy").
		Create(&supplierRequest).Error

	if err != nil {
		return errors.New(moduleName + ".error: " + err.Error())
	}

	return nil
}

// Implement RetrieveSupplierByCode for repository.
func (s *supplierRepository) RetrieveSupplierByCode(supplierCode string) (*supplierModel.MsSuppliers, error) {
	moduleName := baseModule + ".RetrieveSupplierByCode"

	var supplier supplierModel.MsSuppliers

	err := s.conn.Table(entity.EntityMsSuppliers).Where("\"SupplierCode\" = ?", supplierCode).First(&supplier).Error

	if errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, nil
	}

	if err != nil {
		return nil, errors.New(moduleName + ".error: " + err.Error())
	}

	return &supplier, nil
}

// Implement UpdateSupplier for repository.
func (s *supplierRepository) UpdateSupplier(in supplierModel.MsSuppliers) error {
	moduleName := baseModule + ".UpdateSupplier"

	var count int64

	if err := s.conn.Table(entity.EntityMsSuppliers).Where("\"SupplierId\" = ?", in.SupplierId).Count(&count).Error; err != nil {
		return errors.New(moduleName + ".Count.error: " + err.Error())
	}

	if count == 0 {
		return errors.New(constant.DataNotFoundMsg)
	}

	// Update the corporate record with the new values
	err := s.conn.Table(entity.EntityMsSuppliers).
		Where("\"SupplierId\" = ?", in.SupplierId).
		Updates(map[string]interface{}{
			"SupplierCode": in.SupplierCode,
			"SupplierName": in.SupplierName,
			"Address":      in.Address,
			"IsActive":     in.IsActive,
			"UpdatedDate":  in.UpdatedDate, // Update to the current time
			"UpdatedBy":    in.UpdatedBy,   // The user who initiated the update
		}).Error

	if err != nil {
		return errors.New(moduleName + ".Updates.error: " + err.Error())
	}

	return nil
}

// Implement DeleteSupplier for repository.
func (s *supplierRepository) DeleteSupplier(supplierCode string) error {
	moduleName := baseModule + ".DeleteSupplier"

	var (
		count    int64
		supplier supplierModel.MsSuppliers
	)

	if err := s.conn.Table(entity.EntityMsSuppliers).Where("\"SupplierCode\" = ?", supplierCode).Count(&count).Error; err != nil {
		return errors.New(moduleName + ".Count.error: " + err.Error())
	}

	// If no supplier record with the specified SupplierCode is found, return an error.
	if count == 0 {
		return errors.New(constant.DataNotFoundMsg)
	}

	// Delete the supplier record from the database.
	err := s.conn.Where("\"SupplierCode\" = ?", supplierCode).Delete(&supplier).Error

	// If an error occurs during the deletion process, return an error with details.
	if err != nil {
		return errors.New(moduleName + ".error: " + err.Error())
	}

	// Return nil error on successful deletion.
	return nil
}
