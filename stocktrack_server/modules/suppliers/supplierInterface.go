package suppliers

import (
	"stocktrack_server/models/supplierModel"
	sharedGlobal "stocktrack_server/shared/global"
	"stocktrack_server/shared/json"
)

type (
	SupplierUsecases interface {
		GetAllSuppliers(paginationRequest sharedGlobal.PaginationRequest) ([]supplierModel.SupplierResponse, *json.PaginationResponse, error)
		CreateSupplier(supplierRequest supplierModel.SupplierRequest, token string) error
		GetDetailSupplier(supplierCode string) (*supplierModel.SupplierResponse, error)
		UpdateSupplier(supplierRequest supplierModel.SupplierUpdateRequest, token string) error
		DeleteSupplier(supplierCode string) error
	}
	SupplierRepositories interface {
		RetrieveAllSupplier(paginationRequest sharedGlobal.PaginationData) ([]supplierModel.MsSuppliers, int64, error)
		CreateSupplier(supplierRequest supplierModel.MsSuppliers) error
		RetrieveSupplierByCode(supplierCode string) (*supplierModel.MsSuppliers, error)
		UpdateSupplier(supplierRequest supplierModel.MsSuppliers) error
		DeleteSupplier(supplierCode string) error
	}
)
