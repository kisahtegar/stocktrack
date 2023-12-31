import 'package:dartz/dartz.dart';
import 'package:stocktrack_flutter/core/errors/exceptions.dart';
import 'package:stocktrack_flutter/core/errors/failures.dart';
import 'package:stocktrack_flutter/core/utils/typedefs.dart';
import 'package:stocktrack_flutter/src/supplier/data/datasources/supplier_remote_data_src.dart';
import 'package:stocktrack_flutter/src/supplier/domain/entities/supplier_entity.dart';
import 'package:stocktrack_flutter/src/supplier/domain/repos/supplier_repo.dart';

/// Implementation of [SupplierRepo] responsible for handling supplier
/// repository operations.
class SupplierRepoImpl implements SupplierRepo {
  /// Constructor to create an instance of [SupplierRepoImpl].
  ///
  /// Requires an instance of [SupplierRemoteDataSrc] as a parameter.
  SupplierRepoImpl(this._remoteDataSrc);

  final SupplierRemoteDataSrc _remoteDataSrc;

  /// Performs add supplier using the provided [supplierCreateRequest].
  ///
  /// Returns a [ResultFuture] wrapping [SupplierCreateResponse] on success,
  /// or a [Left] wrapping [ServerFailure] on failure.
  @override
  ResultFuture<SupplierCreateResponse> addSupplier(
    SupplierCreateRequest supplierCreateRequest,
  ) async {
    try {
      // Call the addSupplier method on the remote data source
      final result = await _remoteDataSrc.addSupplier(supplierCreateRequest);

      // Return the result wrapped in a Right
      return Right(result);
    } on ServerException catch (e) {
      // Handle ServerException and return a Left wrapping ServerFailure
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  /// Performs delete supplier using the provided [supplierDeleteRequest].
  ///
  /// Returns a [ResultFuture] wrapping [SupplierDeleteResponse] on success,
  /// or a [Left] wrapping [ServerFailure] on failure.
  @override
  ResultFuture<SupplierDeleteResponse> deleteSupplier(
    SupplierDeleteRequest supplierDeleteRequest,
  ) async {
    try {
      // Call the deleteSupplier method on the remote data source
      final result = await _remoteDataSrc.deleteSupplier(supplierDeleteRequest);

      // Return the result wrapped in a Right
      return Right(result);
    } on ServerException catch (e) {
      // Handle ServerException and return a Left wrapping ServerFailure
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  /// Performs delete supplier using the provided [supplierDetailRequest].
  ///
  /// Returns a [ResultFuture] wrapping [SupplierDetailResponse] on success,
  /// or a [Left] wrapping [ServerFailure] on failure.
  @override
  ResultFuture<SupplierDetailResponse> getDetailSupplier(
    SupplierDetailRequest supplierDetailRequest,
  ) async {
    try {
      // Call the getDetailSupplier method on the remote data source
      final result = await _remoteDataSrc.getDetailSupplier(
        supplierDetailRequest,
      );

      // Return the result wrapped in a Right
      return Right(result);
    } on ServerException catch (e) {
      // Handle ServerException and return a Left wrapping ServerFailure
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  /// Performs delete supplier using the provided [supplierListRequest].
  ///
  /// Returns a [ResultFuture] wrapping [SupplierListResponse] on success,
  /// or a [Left] wrapping [ServerFailure] on failure.
  @override
  ResultFuture<SupplierListResponse> getSuppliers(
    SupplierListRequest supplierListRequest,
  ) async {
    try {
      // Call the getSuppliers method on the remote data source
      final result = await _remoteDataSrc.getSuppliers(supplierListRequest);

      // Return the result wrapped in a Right
      return Right(result);
    } on ServerException catch (e) {
      // Handle ServerException and return a Left wrapping ServerFailure
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  /// Performs delete supplier using the provided [supplierUpdateRequest].
  ///
  /// Returns a [ResultFuture] wrapping [SupplierUpdateResponse] on success,
  /// or a [Left] wrapping [ServerFailure] on failure.
  @override
  ResultFuture<SupplierUpdateResponse> updateSupplier(
    SupplierUpdateRequest supplierUpdateRequest,
  ) async {
    try {
      // Call the updateSupplier method on the remote data source
      final result = await _remoteDataSrc.updateSupplier(supplierUpdateRequest);

      // Return the result wrapped in a Right
      return Right(result);
    } on ServerException catch (e) {
      // Handle ServerException and return a Left wrapping ServerFailure
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
