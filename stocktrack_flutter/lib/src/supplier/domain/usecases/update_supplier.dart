import 'package:stocktrack_flutter/core/usecases/usecases.dart';
import 'package:stocktrack_flutter/core/utils/typedefs.dart';
import 'package:stocktrack_flutter/src/supplier/domain/entities/supplier_request.dart';
import 'package:stocktrack_flutter/src/supplier/domain/entities/supplier_response.dart';
import 'package:stocktrack_flutter/src/supplier/domain/repos/supplier_repo.dart';

/// Represents a use case for updating an existing supplier.
///
/// This class extends [FutureUsecaseWithParams], specifying the response type
/// as [SupplierUpdateResponse] and the parameter type [SupplierUpdateRequest].
class UpdateSupplier extends FutureUsecaseWithParams<SupplierUpdateResponse,
    SupplierUpdateRequest> {
  /// Constructor for the [UpdateSupplier] use case.
  ///
  /// Requires a [SupplierRepo] instance to interact with  supplier repository.
  const UpdateSupplier(this._repo);

  final SupplierRepo _repo;

  @override
  ResultFuture<SupplierUpdateResponse> call(SupplierUpdateRequest params) =>
      _repo.updateSupplier(params);
}
