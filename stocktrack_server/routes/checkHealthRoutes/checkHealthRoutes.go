package checkHealthRoutes

import (
	"stocktrack_server/modules/checkHealth/checkHealthHandler"
	"stocktrack_server/modules/checkHealth/checkHealthUsecase"

	"github.com/gin-gonic/gin"
)

func CheckHealthRoutes(v1Group *gin.RouterGroup) {
	checkHealthUC := checkHealthUsecase.NewCheckHealthUsecase()
	checkHealthHandler.NewCheckHealthHandler(v1Group, checkHealthUC)
}
