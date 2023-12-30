import 'package:stocktrack_flutter/core/usecases/usecases.dart';
import 'package:stocktrack_flutter/core/utils/typedefs.dart';
import 'package:stocktrack_flutter/src/supplier/domain/entities/supplier_request.dart';
import 'package:stocktrack_flutter/src/supplier/domain/entities/supplier_response.dart';
import 'package:stocktrack_flutter/src/supplier/domain/repos/supplier_repo.dart';

/// Represents a use case for adding a new supplier.
///
/// This class extends [FutureUsecaseWithParams], specifying the response type
/// as [SupplierCreateResponse] and the parameter type [SupplierCreateRequest].
class AddSupplier extends FutureUsecaseWithParams<SupplierCreateResponse,
    SupplierCreateRequest> {
  /// Constructor for the [AddSupplier] use case.
  ///
  /// Requires a [SupplierRepo] instance to interact with supplier repository.
  const AddSupplier(this._repo);

  final SupplierRepo _repo;

  @override
  ResultFuture<SupplierCreateResponse> call(SupplierCreateRequest params) =>
      _repo.addSupplier(params);
}
