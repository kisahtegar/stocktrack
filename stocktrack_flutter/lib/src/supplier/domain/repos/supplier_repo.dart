import 'package:stocktrack_flutter/core/utils/typedefs.dart';
import 'package:stocktrack_flutter/src/supplier/domain/entities/supplier_request.dart';
import 'package:stocktrack_flutter/src/supplier/domain/entities/supplier_response.dart';

/// Abstract class defining the contract for interacting with supplier data.
abstract class SupplierRepo {
  /// Constructor for SupplierRepo.
  const SupplierRepo();

  /// Fetches a list of suppliers.
  ///
  /// Parameters:
  /// - [supplierListRequest]: Object containing optional parameters for the
  /// request.
  ///
  /// Returns a `ResultFuture` containing a `SupplierListResponse`.
  ResultFuture<SupplierListResponse> getSuppliers(
    SupplierListRequest supplierListRequest,
  );

  /// Fetches details of a specific supplier.
  ///
  /// Parameters:
  /// - [supplierDetailRequest]: Object containing parameters for the request.
  /// Returns a `ResultFuture` containing a `SupplierDetailResponse`.
  ResultFuture<SupplierDetailResponse> getDetailSupplier(
    SupplierDetailRequest supplierDetailRequest,
  );

  /// Adds a new supplier.
  ///
  /// Parameters:
  /// - [supplierCreateRequest]: Object containing data for creating a new
  /// supplier.
  ///
  /// Returns a `ResultFuture` containing a `SupplierCreateResponse`.
  ResultFuture<SupplierCreateResponse> addSupplier(
    SupplierCreateRequest supplierCreateRequest,
  );

  /// Updates an existing supplier.
  ///
  /// Parameters:
  /// - [supplierUpdateRequest]: Object containing data for updating an existing
  /// supplier.
  ///
  /// Returns a `ResultFuture` containing a `SupplierUpdateResponse`.
  ResultFuture<SupplierUpdateResponse> updateSupplier(
    SupplierUpdateRequest supplierUpdateRequest,
  );

  /// Deletes a supplier.
  ///
  /// Parameters:
  /// - [supplierDeleteRequest]: Object containing data for deleting a supplier.
  ///
  /// Returns a `ResultFuture` containing a `SupplierDeleteResponse`.
  ResultFuture<SupplierDeleteResponse> deleteSupplier(
    SupplierDeleteRequest supplierDeleteRequest,
  );
}
