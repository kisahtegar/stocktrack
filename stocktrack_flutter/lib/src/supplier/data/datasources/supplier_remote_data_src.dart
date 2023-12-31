import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:stocktrack_flutter/core/errors/dio_exception_handler.dart';
import 'package:stocktrack_flutter/core/errors/exceptions.dart';
import 'package:stocktrack_flutter/core/res/app_constants.dart';
import 'package:stocktrack_flutter/core/services/injection_container.dart';
import 'package:stocktrack_flutter/core/utils/http_util.dart';
import 'package:stocktrack_flutter/src/supplier/data/models/supplier_model.dart';
import 'package:stocktrack_flutter/src/supplier/domain/entities/supplier_entity.dart';

/// Abstract class defining the contract for supplier remote data source.
abstract class SupplierRemoteDataSrc {
  const SupplierRemoteDataSrc();

  /// Performs add supplier using the provided [supplierCreateRequest].
  ///
  /// Throws a [ServerException] in case of errors.
  Future<SupplierCreateResponse> addSupplier(
    SupplierCreateRequest supplierCreateRequest,
  );

  /// Performs delete supplier using the provided [supplierDeleteRequest].
  ///
  /// Throws a [ServerException] in case of errors.
  Future<SupplierDeleteResponse> deleteSupplier(
    SupplierDeleteRequest supplierDeleteRequest,
  );

  /// Performs get detail supplier using the provided [supplierDetailRequest].
  ///
  /// Throws a [ServerException] in case of errors.
  Future<SupplierDetailResponse> getDetailSupplier(
    SupplierDetailRequest supplierDetailRequest,
  );

  /// Performs get suppliers using the provided [supplierListRequest].
  ///
  /// Throws a [ServerException] in case of errors.
  Future<SupplierListResponseModel> getSuppliers(
    SupplierListRequest supplierListRequest,
  );

  /// Performs update supplier using the provided [supplierUpdateRequest].
  ///
  /// Throws a [ServerException] in case of errors.
  Future<SupplierUpdateResponse> updateSupplier(
    SupplierUpdateRequest supplierUpdateRequest,
  );
}

/// Implementation of [SupplierRemoteDataSrc] responsible for handling supplier
/// requests to the remote server.
class SupplierRemoteDataSrcImpl implements SupplierRemoteDataSrc {
  @override
  Future<SupplierCreateResponse> addSupplier(
    SupplierCreateRequest supplierCreateRequest,
  ) async {
    try {
      debugPrint('SupplierRemoteDataSrc.addSupplier: Running...');

      final response = await sl<HttpUtil>().post(
        '${AppConstants.GET_SUPPLIERS_ENDPOINT}/create',
        data: jsonEncode({
          'supplier_code': supplierCreateRequest.supplierCode,
          'supplier_name': supplierCreateRequest.supplierName,
          'address': supplierCreateRequest.address,
          'contact': supplierCreateRequest.contact,
          'is_active': supplierCreateRequest.isActive,
        }),
      );

      final supplierCreateResponse = SupplierCreateResponseModel.fromJson(
        response.toString(),
      );

      if (supplierCreateResponse.code != '200') {
        throw ServerException(
          message: supplierCreateResponse.message ?? 'Something error',
          statusCode: supplierCreateResponse.code ?? '501',
        );
      }

      return supplierCreateResponse;
    } on ServerException {
      // Rethrow ServerException to propagate the error
      rethrow;
    } on DioException catch (e) {
      // Handle DioException using DioExceptionHandler
      DioExceptionHandler.handleError(e.response);
      // Rethrow DioException to propagate the error
      rethrow;
    } catch (e) {
      // Handle other exceptions and wrap them in a ServerException
      throw ServerException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }

  @override
  Future<SupplierDeleteResponse> deleteSupplier(
    SupplierDeleteRequest supplierDeleteRequest,
  ) async {
    try {
      debugPrint('SupplierRemoteDataSrc.getDetailSupplier: Running...');

      final response = await sl<HttpUtil>().delete(
        '${AppConstants.GET_SUPPLIERS_ENDPOINT}/delete/${supplierDeleteRequest.supplierCode}',
      );

      final supplierDeleteResponse = SupplierDeleteResponseModel.fromJson(
        response.toString(),
      );

      if (supplierDeleteResponse.code != '200') {
        throw ServerException(
          message: supplierDeleteResponse.message ?? 'Something error',
          statusCode: supplierDeleteResponse.code ?? '501',
        );
      }

      return supplierDeleteResponse;
    } on ServerException {
      // Rethrow ServerException to propagate the error
      rethrow;
    } on DioException catch (e) {
      // Handle DioException using DioExceptionHandler
      DioExceptionHandler.handleError(e.response);
      // Rethrow DioException to propagate the error
      rethrow;
    } catch (e) {
      // Handle other exceptions and wrap them in a ServerException
      throw ServerException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }

  @override
  Future<SupplierDetailResponse> getDetailSupplier(
    SupplierDetailRequest supplierDetailRequest,
  ) async {
    try {
      debugPrint('SupplierRemoteDataSrc.getDetailSupplier: Running...');

      final response = await sl<HttpUtil>().get(
        '${AppConstants.GET_SUPPLIERS_ENDPOINT}/${supplierDetailRequest.supplierCode}',
      );

      final supplierDetailResponse = SupplierDetailResponseModel.fromJson(
        response.toString(),
      );

      if (supplierDetailResponse.code != '200') {
        throw ServerException(
          message: supplierDetailResponse.data.toString(),
          statusCode: supplierDetailResponse.code ?? '501',
        );
      }

      return supplierDetailResponse;
    } on ServerException {
      // Rethrow ServerException to propagate the error
      rethrow;
    } on DioException catch (e) {
      // Handle DioException using DioExceptionHandler
      DioExceptionHandler.handleError(e.response);
      // Rethrow DioException to propagate the error
      rethrow;
    } catch (e) {
      // Handle other exceptions and wrap them in a ServerException
      throw ServerException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }

  @override
  Future<SupplierListResponseModel> getSuppliers(
    SupplierListRequest supplierListRequest,
  ) async {
    try {
      debugPrint('SupplierRemoteDataSrc.getSuppliers: Running...');

      final response = await sl<HttpUtil>().get(
        AppConstants.GET_SUPPLIERS_ENDPOINT,
        queryParameters: {
          'page': supplierListRequest.page,
          'limit': supplierListRequest.limit,
          'search': supplierListRequest.search,
        },
      );

      final supplierListResponse = SupplierListResponseModel.fromJson(
        response.toString(),
      );

      if (supplierListResponse.code != '200') {
        throw ServerException(
          message: supplierListResponse.data.toString(),
          statusCode: supplierListResponse.code ?? '501',
        );
      }

      return supplierListResponse;
    } on ServerException {
      // Rethrow ServerException to propagate the error
      rethrow;
    } on DioException catch (e) {
      // Handle DioException using DioExceptionHandler
      DioExceptionHandler.handleError(e.response);
      // Rethrow DioException to propagate the error
      rethrow;
    } catch (e) {
      // Handle other exceptions and wrap them in a ServerException
      throw ServerException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }

  @override
  Future<SupplierUpdateResponse> updateSupplier(
    SupplierUpdateRequest supplierUpdateRequest,
  ) async {
    try {
      debugPrint('SupplierRemoteDataSrc.updateSupplier: Running...');

      final response = await sl<HttpUtil>().update(
        '${AppConstants.GET_SUPPLIERS_ENDPOINT}/update',
        data: jsonEncode({
          'supplier_id': supplierUpdateRequest.supplierId,
          'supplier_code': supplierUpdateRequest.supplierCode,
          'supplier_name': supplierUpdateRequest.supplierName,
          'address': supplierUpdateRequest.address,
          'contact': supplierUpdateRequest.contact,
          'is_active': supplierUpdateRequest.isActive,
        }),
      );

      final supplierUpdateResponse = SupplierUpdateResponseModel.fromJson(
        response.toString(),
      );

      if (supplierUpdateResponse.code != '200') {
        throw ServerException(
          message: supplierUpdateResponse.message ?? 'Something error',
          statusCode: supplierUpdateResponse.code ?? '501',
        );
      }

      return supplierUpdateResponse;
    } on ServerException {
      // Rethrow ServerException to propagate the error
      rethrow;
    } on DioException catch (e) {
      // Handle DioException using DioExceptionHandler
      DioExceptionHandler.handleError(e.response);
      // Rethrow DioException to propagate the error
      rethrow;
    } catch (e) {
      // Handle other exceptions and wrap them in a ServerException
      throw ServerException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }
}
