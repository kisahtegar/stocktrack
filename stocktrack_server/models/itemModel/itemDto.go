package itemModel

type (
	ItemResponse struct {
		ItemId      int32  `json:"item_id"`
		SupplierId  int32  `json:"supplier_id"`
		ItemCode    string `json:"item_code"`
		ItemName    string `json:"item_name"`
		Description string `json:"description"`
		Cost        string `json:"cost"`
	}

	ItemRequest struct {
		SupplierId  int32  `json:"supplier_id"`
		ItemCode    string `json:"item_code"`
		ItemName    string `json:"item_name"`
		Description string `json:"description"`
		Cost        string `json:"cost"`
		IsActive    int32  `json:"is_active"`
	}

	ItemUpdateRequest struct {
		ItemId      int32  `json:"item_id"`
		SupplierId  int32  `json:"supplier_id"`
		ItemCode    string `json:"item_code"`
		ItemName    string `json:"item_name"`
		Description string `json:"description"`
		Cost        string `json:"cost"`
		IsActive    int32  `json:"is_active"`
	}
)
