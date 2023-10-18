package checkHealthHandler

import (
	"stocktrack_server/middlewares/auth"
	"stocktrack_server/modules/checkHealth"
	"stocktrack_server/shared/constant"
	"stocktrack_server/shared/json"

	"github.com/gin-gonic/gin"
)

type checkHealthHandler struct {
	checkHealthUsecase checkHealth.CheckHealthUsecase
}

// NewWelcomeHandler
func NewCheckHealthHandler(v1Group *gin.RouterGroup, checkHealthUsecase checkHealth.CheckHealthUsecase) {
	handler := checkHealthHandler{
		checkHealthUsecase: checkHealthUsecase,
	}

	v1Group.GET("/check", auth.JwtAuth, handler.CheckHealth)
}

func (handler *checkHealthHandler) CheckHealth(c *gin.Context) {
	result, err := handler.checkHealthUsecase.CheckHealth()
	if err != nil {
		json.NewResponseError(c, err.Error(), constant.ServiceCodeCheckHealth, constant.SuccessCode)
		return
	}
	json.NewResponseSuccess(c, nil, result, constant.ServiceCodeCheckHealth, constant.SuccessCode)
}
