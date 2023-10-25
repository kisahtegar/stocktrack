package items

import (
	"stocktrack_server/models/itemModel"
	sharedGlobal "stocktrack_server/shared/global"
	"stocktrack_server/shared/json"
)

type (
	ItemUsecases interface {
		GetAllItems(paginationRequest sharedGlobal.PaginationRequest) ([]itemModel.ItemResponse, *json.PaginationResponse, error)
		CreateItem(itemRequest itemModel.ItemRequest, token string) error
		GetDetailItem(itemCode string) (*itemModel.ItemResponse, error)
		UpdateItem(itemRequest itemModel.ItemUpdateRequest, token string) error
		DeleteItem(itemCode string) error
	}
	ItemRepositories interface {
		RetrieveAllItem(paginationRequest sharedGlobal.PaginationData) ([]itemModel.MsItems, int64, error)
		CreateItem(itemRequest itemModel.MsItems) error
		RetrieveItemByCode(itemCode string) (*itemModel.MsItems, error)
		UpdateItem(itemRequest itemModel.MsItems) error
		DeleteItem(itemCode string) error
	}
)
