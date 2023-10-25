package supplierRoutes

import (
	"stocktrack_server/middlewares/logErrors"
	"stocktrack_server/modules/suppliers/supplierHandler"
	"stocktrack_server/modules/suppliers/supplierRepository"
	"stocktrack_server/modules/suppliers/supplierUsecase"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func SupplierRoutes(v1Group *gin.RouterGroup, conn *gorm.DB, logUc logErrors.LogErrorsUsecase) {
	supplierRepo := supplierRepository.NewSupplierRepository(conn)
	supplierUc := supplierUsecase.NewSupplierUsecase(supplierRepo)
	supplierHandler.NewSupplierHandler(v1Group, supplierUc, logUc)
}
