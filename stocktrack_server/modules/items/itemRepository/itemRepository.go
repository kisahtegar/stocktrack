package itemRepository

import (
	"errors"
	"stocktrack_server/models/itemModel"
	"stocktrack_server/modules/items"
	"stocktrack_server/shared/constant"
	"stocktrack_server/shared/entity"
	sharedGlobal "stocktrack_server/shared/global"

	"gorm.io/gorm"
)

const baseModule = "itemRepository"

type itemRepository struct {
	conn *gorm.DB
}

func NewItemRepository(conn *gorm.DB) items.ItemRepositories {
	return &itemRepository{
		conn: conn,
	}
}

// Implement RetrieveAllItem for repository.
func (i *itemRepository) RetrieveAllItem(paginationData sharedGlobal.PaginationData) ([]itemModel.MsItems, int64, error) {
	var (
		items []itemModel.MsItems
		count int64
		err   error
	)

	if paginationData.Search != "" {

		err = i.conn.Table(entity.EntityMsItems).
			Where("(concat(\"ItemCode\",\"ItemName\") LIKE ?)", "%"+paginationData.Search+"%").
			Limit(paginationData.Limit).
			Offset(paginationData.Offset).
			Find(&items).
			Offset(-1).
			Limit(-1).
			Count(&count).Error
	} else {

		err = i.conn.Table(entity.EntityMsItems).
			Limit(paginationData.Limit).
			Offset(paginationData.Offset).
			Find(&items).
			Offset(-1).
			Limit(-1).
			Count(&count).Error
	}

	if err != nil {
		return nil, 0, errors.New(baseModule + ".RetrieveAllItem.error: " + err.Error())
	}

	return items, count, nil
}

// Implement CreateItem for repository.
func (i *itemRepository) CreateItem(itemRequest itemModel.MsItems) error {
	moduleName := baseModule + ".CreateItem"

	// Check if ItemCode already exists.
	var existingItem itemModel.MsItems

	err := i.conn.Table(entity.EntityMsItems).
		Where("\"ItemCode\" = ?", itemRequest.ItemCode).
		First(&existingItem).Error

	if err == nil {
		// If record with the same ItemCode exists, return an error
		return errors.New(moduleName + ".error: ItemCode = " + itemRequest.ItemCode + " already exists")
	} else if !errors.Is(err, gorm.ErrRecordNotFound) {
		// If any other error while database query
		return errors.New(moduleName + ".error: " + err.Error())
	}

	// If ItemCode doesnt exist RecordNotFound and create new one.
	err = i.conn.Table(entity.EntityMsItems).
		Select("SupplierId", "ItemCode", "ItemName", "Description", "Cost", "IsActive", "CreatedDate", "CreatedBy").
		Create(&itemRequest).Error

	if err != nil {
		return errors.New(moduleName + ".error: " + err.Error())
	}

	return nil
}

// Implement RetrieveItemByCode for repository.
func (i *itemRepository) RetrieveItemByCode(itemCode string) (*itemModel.MsItems, error) {
	moduleName := baseModule + ".RetrieveItemByCode"

	var item itemModel.MsItems

	err := i.conn.Table(entity.EntityMsItems).Where("\"ItemCode\" = ?", itemCode).First(&item).Error

	if errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, nil
	}

	if err != nil {
		return nil, errors.New(moduleName + ".error: " + err.Error())
	}

	return &item, nil
}

// Implement UpdateItem for repository.
func (i *itemRepository) UpdateItem(in itemModel.MsItems) error {
	moduleName := baseModule + ".UpdateItem"

	var count int64

	if err := i.conn.Table(entity.EntityMsItems).Where("\"ItemId\" = ?", in.ItemId).Count(&count).Error; err != nil {
		return errors.New(moduleName + ".Count.error: " + err.Error())
	}

	if count == 0 {
		return errors.New(constant.DataNotFoundMsg)
	}

	// Update the corporate record with the new values
	err := i.conn.Table(entity.EntityMsItems).
		Where("\"ItemId\" = ?", in.ItemId).
		Updates(map[string]interface{}{
			"SupplierId":  in.SupplierId,
			"ItemCode":    in.ItemCode,
			"ItemName":    in.ItemName,
			"Description": in.Description,
			"Cost":        in.Cost,
			"IsActive":    in.IsActive,
			"UpdatedDate": in.UpdatedDate, // Update to the current time
			"UpdatedBy":   in.UpdatedBy,   // The user who initiated the update
		}).Error

	if err != nil {
		return errors.New(moduleName + ".Updates.error: " + err.Error())
	}

	return nil
}

// Implement DeleteItem for repository.
func (i *itemRepository) DeleteItem(itemCode string) error {
	moduleName := baseModule + ".DeleteItem"

	var (
		count int64
		item  itemModel.MsItems
	)

	if err := i.conn.Table(entity.EntityMsItems).Where("\"ItemCode\" = ?", itemCode).Count(&count).Error; err != nil {
		return errors.New(moduleName + ".Count.error: " + err.Error())
	}

	// If no item record with the specified ItemCode is found, return an error.
	if count == 0 {
		return errors.New(constant.DataNotFoundMsg)
	}

	// Delete the item record from the database.
	err := i.conn.Where("\"ItemCode\" = ?", itemCode).Delete(&item).Error

	// If an error occurs during the deletion process, return an error with details.
	if err != nil {
		return errors.New(moduleName + ".error: " + err.Error())
	}

	// Return nil error on successful deletion.
	return nil
}
