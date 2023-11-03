package itemUsecase

import (
	"database/sql"
	"math"
	"stocktrack_server/models/itemModel"
	"stocktrack_server/modules/items"
	jwtService "stocktrack_server/services/jwt"
	sharedGlobal "stocktrack_server/shared/global"
	"stocktrack_server/shared/json"
	"time"
)

type itemUsecase struct {
	itemRepo items.ItemRepositories
}

func NewItemUsecase(itemRepo items.ItemRepositories) items.ItemUsecases {
	return &itemUsecase{
		itemRepo: itemRepo,
	}
}

// Implement GetAllItems for usecase.
func (i *itemUsecase) GetAllItems(paginationRequest sharedGlobal.PaginationRequest) ([]itemModel.ItemResponse, *json.PaginationResponse, error) {
	paginationData := sharedGlobal.NewPaginationData(paginationRequest)

	items, count, err := i.itemRepo.RetrieveAllItem(paginationData)
	if err != nil {
		return nil, nil, err
	}

	var itemResponses = []itemModel.ItemResponse{}

	for _, item := range items {
		itemResponses = append(itemResponses, itemModel.ItemResponse{
			ItemId:      item.ItemId,
			SupplierId:  item.SupplierId,
			ItemCode:    item.ItemCode,
			ItemName:    item.ItemName,
			Description: item.Description,
			Cost:        item.Cost,
		})
	}

	paginationResponse := json.PaginationResponse{
		TotalData: count,
		TotalPage: int32(math.Ceil(float64(count) / float64(paginationData.Limit))),
		Page:      int32(paginationData.Page),
		Limit:     int16(paginationData.Limit),
	}

	return itemResponses, &paginationResponse, nil
}

// Implement CreateItem for usecase.
func (i *itemUsecase) CreateItem(itemRequest itemModel.ItemRequest, token string) error {
	parseToken, err := jwtService.ExtractAndParseJWT(token)
	if err != nil {
		return err
	}

	item := itemModel.MsItems{
		SupplierId:  itemRequest.SupplierId,
		ItemCode:    itemRequest.ItemCode,
		ItemName:    itemRequest.ItemName,
		Description: itemRequest.Description,
		Cost:        itemRequest.Cost,
		IsActive:    itemRequest.IsActive,
		CreatedDate: time.Now(),
		CreatedBy:   parseToken.Username,
	}

	err = i.itemRepo.CreateItem(item)
	if err != nil {
		return err
	}

	return nil
}

// Implement GetDetailItem for usecase.
func (i *itemUsecase) GetDetailItem(itemCode string) (*itemModel.ItemResponse, error) {
	item, err := i.itemRepo.RetrieveItemByCode(itemCode)
	if err != nil {
		return nil, err
	}
	if item == nil {
		return nil, nil
	}

	itemResponse := itemModel.ItemResponse{
		ItemId:      item.ItemId,
		SupplierId:  item.SupplierId,
		ItemCode:    item.ItemCode,
		ItemName:    item.ItemName,
		Description: item.Description,
		Cost:        item.Cost,
	}

	return &itemResponse, nil
}

// Implement UpdateItem for usecase.
func (i *itemUsecase) UpdateItem(itemRequest itemModel.ItemUpdateRequest, token string) error {
	parseToken, err := jwtService.ExtractAndParseJWT(token)
	if err != nil {
		return err
	}

	item := itemModel.MsItems{
		ItemId:      itemRequest.ItemId,
		SupplierId:  itemRequest.SupplierId,
		ItemCode:    itemRequest.ItemCode,
		ItemName:    itemRequest.ItemName,
		Description: itemRequest.Description,
		Cost:        itemRequest.Cost,
		IsActive:    itemRequest.IsActive,
		UpdatedDate: sql.NullTime{Time: time.Now(), Valid: true},
		UpdatedBy:   sql.NullString{String: parseToken.Username, Valid: true},
	}

	if err = i.itemRepo.UpdateItem(item); err != nil {
		return err
	}

	return nil
}

// Implement DeleteItem for usecase.
func (i *itemUsecase) DeleteItem(itemCode string) error {
	// Attempt to delete the item record from the repository using the provided ID.
	err := i.itemRepo.DeleteItem(itemCode)

	// Check if an error occurred during the deletion process.
	if err != nil {
		return err
	}

	// Return `nil` to indicate a successful deletion.
	return nil
}
