import 'package:stocktrack_flutter/core/usecases/usecases.dart';
import 'package:stocktrack_flutter/core/utils/typedefs.dart';
import 'package:stocktrack_flutter/src/supplier/domain/entities/supplier_entity.dart';
import 'package:stocktrack_flutter/src/supplier/domain/repos/supplier_repo.dart';

/// Represents a use case for fetching details of a specific supplier.
///
/// This class extends [FutureUsecaseWithParams], specifying the response type
/// as [SupplierDetailResponse] and the parameter type [SupplierDetailRequest].
class GetDetailSupplier extends FutureUsecaseWithParams<SupplierDetailResponse,
    SupplierDetailRequest> {
  /// Constructor for the [GetDetailSupplier] use case.
  ///
  /// Requires a [SupplierRepo] instance to interact with supplier repository.
  const GetDetailSupplier(this._repo);

  final SupplierRepo _repo;

  @override
  ResultFuture<SupplierDetailResponse> call(SupplierDetailRequest params) =>
      _repo.getDetailSupplier(params);
}
