package supplierHandler

import (
	"net/http"
	"stocktrack_server/middlewares/auth"
	"stocktrack_server/middlewares/logErrors"
	"stocktrack_server/models/supplierModel"
	"stocktrack_server/modules/suppliers"
	"stocktrack_server/services/global"
	"stocktrack_server/services/validation"
	"stocktrack_server/shared/constant"
	sharedGlobal "stocktrack_server/shared/global"
	"stocktrack_server/shared/json"

	"github.com/gin-gonic/gin"
)

type supplierHandler struct {
	supplierUsecases suppliers.SupplierUsecases
	logUsecase       logErrors.LogErrorsUsecase
}

func NewSupplierHandler(v1Group *gin.RouterGroup, supplierUsecases suppliers.SupplierUsecases, logUC logErrors.LogErrorsUsecase) {
	supplierHandler := &supplierHandler{
		supplierUsecases: supplierUsecases,
		logUsecase:       logUC,
	}
	supplierGroup := v1Group.Group("/supplier")
	supplierGroup.Use(auth.JwtAuth)
	{
		supplierGroup.GET("", supplierHandler.getAllSuppliers)
		supplierGroup.POST("/create", supplierHandler.createSupplier)
		supplierGroup.GET("/:supplierCode", supplierHandler.getDetailSupplier)
		supplierGroup.PUT("/update", supplierHandler.updateSupplier)
		supplierGroup.DELETE("/delete/:supplierCode", supplierHandler.deleteSupplier)
	}
}

// Implement handler getAllSuppliers
func (e *supplierHandler) getAllSuppliers(c *gin.Context) {
	page := c.Query("page")
	limit := c.Query("limit")
	search := c.Query("search")
	paginationRequest := sharedGlobal.PaginationRequest{
		Offset: page,
		Limit:  limit,
		Search: search,
	}

	token := global.GetToken(c)

	supplierResponses, paginationResponse, err := e.supplierUsecases.GetAllSuppliers(paginationRequest)

	isError := e.logUsecase.CheckIsError(err, token, c.HandlerName())
	if isError {
		json.NewResponseError(c, err.Error(), constant.ServiceCodeSupplier, constant.ErrCodeGeneralError)
		return
	}

	json.NewResponsePagination(c, supplierResponses, constant.SuccessMessage, constant.ServiceCodeSupplier, constant.SuccessCode, paginationResponse)
}

// Implement handler createSupplier
func (e *supplierHandler) createSupplier(c *gin.Context) {
	var supplierRequest supplierModel.SupplierRequest

	err := c.ShouldBindJSON(&supplierRequest)

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

	err = e.supplierUsecases.CreateSupplier(supplierRequest, token)

	isError := e.logUsecase.CheckIsError(err, token, c.HandlerName())
	if isError {
		json.NewResponseError(c, err.Error(), constant.ServiceCodeSupplier, constant.ErrCodeGeneralError)
		return
	}

	json.NewResponseSuccess(c, nil, constant.SuccessMessage, constant.ServiceCodeSupplier, constant.SuccessCode)
}

// Implement handler getDetail
func (e *supplierHandler) getDetailSupplier(c *gin.Context) {
	supplierCode := c.Param("supplierCode")
	if supplierCode == "" {
		var resultError []json.ValidationField
		data := json.ValidationField{
			FieldName: "supplierCode",
			Message:   "supplierCode cant empty",
		}
		resultError = append(resultError, data)
		json.NewResponseBadRequest(c, resultError, constant.ErrCodeInvalidParam, constant.ServiceCodeSupplier, constant.ErrCodeInvalidParam)
		return
	}

	token := global.GetToken(c)

	result, err := e.supplierUsecases.GetDetailSupplier(supplierCode)

	isError := e.logUsecase.CheckIsError(err, token, c.HandlerName())

	if isError {
		json.NewResponseError(c, err.Error(), constant.ServiceCodeSupplier, constant.ErrCodeGeneralError)
		return
	}

	if result == nil {
		json.NewResponse(c, constant.DataNotFoundMsg, constant.ServiceCodeSupplier, constant.ErrCodeNotFound, http.StatusBadRequest)
		return
	}

	json.NewResponseSuccess(c, result, constant.SuccessMessage, constant.ServiceCodeSupplier, constant.SuccessCode)
}

// Implement handler updateSupplier
func (e *supplierHandler) updateSupplier(c *gin.Context) {
	var supplierRequest supplierModel.SupplierUpdateRequest

	err := c.ShouldBindJSON(&supplierRequest)

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

	err = e.supplierUsecases.UpdateSupplier(supplierRequest, token)

	isError := e.logUsecase.CheckIsError(err, token, c.HandlerName())

	if isError {
		json.NewResponseError(c, err.Error(), constant.ServiceCodeSupplier, constant.ErrCodeGeneralError)
		return
	}

	json.NewResponseSuccess(c, nil, constant.SuccessMessage, constant.ServiceCodeSupplier, constant.SuccessCode)
}

// Implement handler deleteSupplier
func (e *supplierHandler) deleteSupplier(c *gin.Context) {
	supplierCode := c.Param("supplierCode")

	if supplierCode == "" {
		var resultError []json.ValidationField
		data := json.ValidationField{
			FieldName: "supplierCode",
			Message:   "supplierCode cant empty",
		}
		resultError = append(resultError, data)
		json.NewResponseBadRequest(c, resultError, constant.ErrCodeInvalidParam, constant.ServiceCodeSupplier, constant.ErrCodeInvalidParam)
		return
	}
	token := global.GetToken(c)

	err := e.supplierUsecases.DeleteSupplier(supplierCode)

	isError := e.logUsecase.CheckIsError(err, token, c.HandlerName())

	if isError {
		json.NewResponseError(c, err.Error(), constant.ServiceCodeSupplier, constant.ErrCodeGeneralError)
		return
	}

	json.NewResponseSuccess(c, nil, constant.SuccessMessage, constant.ServiceCodeSupplier, constant.SuccessCode)
}
