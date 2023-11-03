package poModel

type (
	PoResponse struct {
		PoId        int32  `json:"po_id"`
		SupplierId  int32  `json:"supplier_id"`
		PoCode      string `json:"po_code"`
		PoName      string `json:"po_name"`
		Description string `json:"description"`
		Cost        string `json:"cost"`
	}

	PoRequest struct {
		SupplierId  int32  `json:"supplier_id"`
		PoCode      string `json:"po_code"`
		PoName      string `json:"po_name"`
		Description string `json:"description"`
		Cost        string `json:"cost"`
		IsActive    int32  `json:"is_active"`
	}

	PoUpdateRequest struct {
		PoId        int32  `json:"po_id"`
		SupplierId  int32  `json:"supplier_id"`
		PoCode      string `json:"po_code"`
		PoName      string `json:"po_name"`
		Description string `json:"description"`
		Cost        string `json:"cost"`
		IsActive    int32  `json:"is_active"`
	}
)
