package itemRoutes

import (
	"stocktrack_server/middlewares/logErrors"
	"stocktrack_server/modules/items/itemHandler"
	"stocktrack_server/modules/items/itemRepository"
	"stocktrack_server/modules/items/itemUsecase"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func ItemRoutes(v1Group *gin.RouterGroup, conn *gorm.DB, logUc logErrors.LogErrorsUsecase) {
	itemRepo := itemRepository.NewItemRepository(conn)
	itemUc := itemUsecase.NewItemUsecase(itemRepo)
	itemHandler.NewItemHandler(v1Group, itemUc, logUc)
}
