package supplierModel

type (
	SupplierResponse struct {
		SupplierId   int32  `json:"supplier_id"`
		SupplierCode string `json:"supplier_code"`
		SupplierName string `json:"supplier_name"`
		Address      string `json:"address"`
		Contact      string `json:"contact"`
		IsActive     int32  `json:"is_active"`
	}

	SupplierRequest struct {
		SupplierCode string `json:"supplier_code"`
		SupplierName string `json:"supplier_name"`
		Address      string `json:"address"`
		Contact      string `json:"contact"`
		IsActive     int32  `json:"is_active"`
	}

	SupplierUpdateRequest struct {
		SupplierId   int32  `json:"supplier_id"`
		SupplierCode string `json:"supplier_code"`
		SupplierName string `json:"supplier_name"`
		Address      string `json:"address"`
		Contact      string `json:"contact"`
		IsActive     int32  `json:"is_active"`
	}
)
