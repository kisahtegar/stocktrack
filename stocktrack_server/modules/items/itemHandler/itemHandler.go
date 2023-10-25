package itemHandler

import (
	"net/http"
	"stocktrack_server/middlewares/auth"
	"stocktrack_server/middlewares/logErrors"
	"stocktrack_server/models/itemModel"
	"stocktrack_server/modules/items"
	"stocktrack_server/services/global"
	"stocktrack_server/services/validation"
	"stocktrack_server/shared/constant"
	sharedGlobal "stocktrack_server/shared/global"
	"stocktrack_server/shared/json"

	"github.com/gin-gonic/gin"
)

type itemHandler struct {
	itemUsecases items.ItemUsecases
	logUsecase   logErrors.LogErrorsUsecase
}

func NewItemHandler(v1Group *gin.RouterGroup, itemUsecases items.ItemUsecases, logUC logErrors.LogErrorsUsecase) {
	itemHandler := &itemHandler{
		itemUsecases: itemUsecases,
		logUsecase:   logUC,
	}
	itemGroup := v1Group.Group("/item")
	itemGroup.Use(auth.JwtAuth)
	{
		itemGroup.GET("", itemHandler.getAllItems)
		itemGroup.POST("/create", itemHandler.createItem)
		itemGroup.GET("/:itemCode", itemHandler.getDetailItem)
		itemGroup.PUT("/update", itemHandler.updateItem)
		itemGroup.DELETE("/delete/:itemCode", itemHandler.deleteItem)
	}
}

// Implement handler getAllItems
func (e *itemHandler) getAllItems(c *gin.Context) {
	page := c.Query("page")
	limit := c.Query("limit")
	search := c.Query("search")
	paginationRequest := sharedGlobal.PaginationRequest{
		Offset: page,
		Limit:  limit,
		Search: search,
	}

	token := global.GetToken(c)

	itemResponses, paginationResponse, err := e.itemUsecases.GetAllItems(paginationRequest)

	isError := e.logUsecase.CheckIsError(err, token, c.HandlerName())
	if isError {
		json.NewResponseError(c, err.Error(), constant.ServiceCodeItem, constant.ErrCodeGeneralError)
		return
	}

	json.NewResponsePagination(c, itemResponses, constant.SuccessMessage, constant.ServiceCodeItem, constant.SuccessCode, paginationResponse)
}

// Implement handler createItem
func (e *itemHandler) createItem(c *gin.Context) {
	var itemRequest itemModel.ItemRequest

	err := c.ShouldBindJSON(&itemRequest)

	if err != nil {
		validations := validation.GetValidationError(err)
		if len(validations) > 0 {
			json.NewResponseBadRequest(c, validations, constant.BadRequestMsg, constant.ServiceCodeUser, constant.SuccessCode)
			return
		}

		json.NewResponseError(c, err.Error(), constant.ServiceCodeUser, constant.ErrCodeGeneralError)
		return
	}

	token := global.GetToken(c)

	err = e.itemUsecases.CreateItem(itemRequest, token)

	isError := e.logUsecase.CheckIsError(err, token, c.HandlerName())
	if isError {
		json.NewResponseError(c, err.Error(), constant.ServiceCodeItem, constant.ErrCodeGeneralError)
		return
	}

	json.NewResponseSuccess(c, nil, constant.SuccessMessage, constant.ServiceCodeItem, constant.SuccessCode)
}

// Implement handler getDetailItem
func (e *itemHandler) getDetailItem(c *gin.Context) {
	itemCode := c.Param("itemCode")
	if itemCode == "" {
		var resultError []json.ValidationField
		data := json.ValidationField{
			FieldName: "itemCode",
			Message:   "itemCode cannot empty",
		}
		resultError = append(resultError, data)
		json.NewResponseBadRequest(c, resultError, constant.ErrCodeInvalidParam, constant.ServiceCodeItem, constant.ErrCodeInvalidParam)
		return
	}

	token := global.GetToken(c)

	result, err := e.itemUsecases.GetDetailItem(itemCode)

	isError := e.logUsecase.CheckIsError(err, token, c.HandlerName())

	if isError {
		json.NewResponseError(c, err.Error(), constant.ServiceCodeItem, constant.ErrCodeGeneralError)
		return
	}

	if result == nil {
		json.NewResponse(c, constant.DataNotFoundMsg, constant.ServiceCodeItem, constant.ErrCodeNotFound, http.StatusBadRequest)
		return
	}

	json.NewResponseSuccess(c, result, constant.SuccessMessage, constant.ServiceCodeItem, constant.SuccessCode)
}

// Implement handler updateItem
func (e *itemHandler) updateItem(c *gin.Context) {
	var itemRequest itemModel.ItemUpdateRequest

	err := c.ShouldBindJSON(&itemRequest)

	if err != nil {
		validations := validation.GetValidationError(err)
		if len(validations) > 0 {
			json.NewResponseBadRequest(c, validations, constant.BadRequestMsg, constant.ServiceCodeUser, constant.SuccessCode)
			return
		}

		json.NewResponseError(c, err.Error(), constant.ServiceCodeUser, constant.ErrCodeGeneralError)
		return
	}

	token := global.GetToken(c)

	err = e.itemUsecases.UpdateItem(itemRequest, token)

	isError := e.logUsecase.CheckIsError(err, token, c.HandlerName())

	if isError {
		json.NewResponseError(c, err.Error(), constant.ServiceCodeItem, constant.ErrCodeGeneralError)
		return
	}

	json.NewResponseSuccess(c, nil, constant.SuccessMessage, constant.ServiceCodeItem, constant.SuccessCode)
}

// Implement handler deleteItem
func (e *itemHandler) deleteItem(c *gin.Context) {
	itemCode := c.Param("itemCode")

	if itemCode == "" {
		var resultError []json.ValidationField
		data := json.ValidationField{
			FieldName: "itemCode",
			Message:   "itemCode cannot empty",
		}
		resultError = append(resultError, data)
		json.NewResponseBadRequest(c, resultError, constant.ErrCodeInvalidParam, constant.ServiceCodeItem, constant.ErrCodeInvalidParam)
		return
	}
	token := global.GetToken(c)

	err := e.itemUsecases.DeleteItem(itemCode)

	isError := e.logUsecase.CheckIsError(err, token, c.HandlerName())

	if isError {
		json.NewResponseError(c, err.Error(), constant.ServiceCodeItem, constant.ErrCodeGeneralError)
		return
	}

	json.NewResponseSuccess(c, nil, constant.SuccessMessage, constant.ServiceCodeItem, constant.SuccessCode)
}
