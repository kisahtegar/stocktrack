import 'package:stocktrack_flutter/core/usecases/usecases.dart';
import 'package:stocktrack_flutter/core/utils/typedefs.dart';
import 'package:stocktrack_flutter/src/supplier/domain/entities/supplier_request.dart';
import 'package:stocktrack_flutter/src/supplier/domain/entities/supplier_response.dart';
import 'package:stocktrack_flutter/src/supplier/domain/repos/supplier_repo.dart';

/// Represents a use case for deleting a supplier.
///
/// This class extends [FutureUsecaseWithParams], specifying the response type
/// as [SupplierDeleteResponse] and the parameter type [SupplierDeleteRequest].
class DeleteSupplier extends FutureUsecaseWithParams<SupplierDeleteResponse,
    SupplierDeleteRequest> {
  /// Constructor for the [DeleteSupplier] use case.
  ///
  /// Requires a [SupplierRepo] instance to interact with supplier repository.
  const DeleteSupplier(this._repo);

  final SupplierRepo _repo;

  @override
  ResultFuture<SupplierDeleteResponse> call(SupplierDeleteRequest params) =>
      _repo.deleteSupplier(params);
}
