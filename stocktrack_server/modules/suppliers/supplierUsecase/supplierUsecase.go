package supplierUsecase

import (
	"database/sql"
	"math"
	"stocktrack_server/models/supplierModel"
	"stocktrack_server/modules/suppliers"
	jwtService "stocktrack_server/services/jwt"
	sharedGlobal "stocktrack_server/shared/global"
	"stocktrack_server/shared/json"
	"time"
)

type supplierUsecase struct {
	supplierRepo suppliers.SupplierRepositories
}

func NewSupplierUsecase(supplierRepo suppliers.SupplierRepositories) suppliers.SupplierUsecases {
	return &supplierUsecase{
		supplierRepo: supplierRepo,
	}
}

// Implement GetAllSuppliers for usecase.
func (s *supplierUsecase) GetAllSuppliers(paginationRequest sharedGlobal.PaginationRequest) ([]supplierModel.SupplierResponse, *json.PaginationResponse, error) {
	paginationData := sharedGlobal.NewPaginationData(paginationRequest)

	suppliers, count, err := s.supplierRepo.RetrieveAllSupplier(paginationData)
	if err != nil {
		return nil, nil, err
	}

	var supplierResponses = []supplierModel.SupplierResponse{}

	for _, supplier := range suppliers {
		supplierResponses = append(supplierResponses, supplierModel.SupplierResponse{
			SupplierId:   supplier.SupplierId,
			SupplierCode: supplier.SupplierCode,
			SupplierName: supplier.SupplierName,
			Address:      supplier.Address,
			Contact:      supplier.Contact,
		})
	}

	paginationResponse := json.PaginationResponse{
		TotalData: count,
		TotalPage: int32(math.Ceil(float64(count) / float64(paginationData.Limit))),
		Page:      int32(paginationData.Page),
		Limit:     int16(paginationData.Limit),
	}

	return supplierResponses, &paginationResponse, nil
}

// Implement CreateSupplier for usecase.
func (s *supplierUsecase) CreateSupplier(supplierRequest supplierModel.SupplierRequest, token string) error {
	parseToken, err := jwtService.ExtractAndParseJWT(token)
	if err != nil {
		return err
	}

	supplier := supplierModel.MsSuppliers{
		SupplierCode: supplierRequest.SupplierCode,
		SupplierName: supplierRequest.SupplierName,
		Address:      supplierRequest.Address,
		Contact:      supplierRequest.Contact,
		IsActive:     supplierRequest.IsActive,
		CreatedDate:  time.Now(),
		CreatedBy:    parseToken.Username,
	}

	err = s.supplierRepo.CreateSupplier(supplier)
	if err != nil {
		return err
	}

	return nil
}

// Implement GetDetailSupplier for usecase.
func (s *supplierUsecase) GetDetailSupplier(supplierCode string) (*supplierModel.SupplierResponse, error) {
	supplier, err := s.supplierRepo.RetrieveSupplierByCode(supplierCode)
	if err != nil {
		return nil, err
	}
	if supplier == nil {
		return nil, nil
	}

	supplierResponse := supplierModel.SupplierResponse{
		SupplierId:   supplier.SupplierId,
		SupplierCode: supplier.SupplierCode,
		SupplierName: supplier.SupplierName,
		Address:      supplier.Address,
		Contact:      supplier.Contact,
	}

	return &supplierResponse, nil
}

// Implement UpdateSupplier for usecase.
func (s *supplierUsecase) UpdateSupplier(supplierRequest supplierModel.SupplierUpdateRequest, token string) error {
	parseToken, err := jwtService.ExtractAndParseJWT(token)
	if err != nil {
		return err
	}

	supplier := supplierModel.MsSuppliers{
		SupplierId:   supplierRequest.SupplierId,
		SupplierCode: supplierRequest.SupplierCode,
		SupplierName: supplierRequest.SupplierName,
		Address:      supplierRequest.Address,
		Contact:      supplierRequest.Contact,
		IsActive:     supplierRequest.IsActive,
		UpdatedDate:  sql.NullTime{Time: time.Now(), Valid: true},
		UpdatedBy:    sql.NullString{String: parseToken.Username, Valid: true},
	}

	if err = s.supplierRepo.UpdateSupplier(supplier); err != nil {
		return err
	}

	return nil
}

// Implement DeleteSupplier for usecase.
func (s *supplierUsecase) DeleteSupplier(supplierCode string) error {
	// Attempt to delete the doctor's record from the repository using the provided ID.
	err := s.supplierRepo.DeleteSupplier(supplierCode)

	// Check if an error occurred during the deletion process.
	if err != nil {
		return err
	}

	// Return `nil` to indicate a successful deletion.
	return nil
}
