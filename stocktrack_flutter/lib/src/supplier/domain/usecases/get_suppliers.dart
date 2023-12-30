import 'package:stocktrack_flutter/core/usecases/usecases.dart';
import 'package:stocktrack_flutter/core/utils/typedefs.dart';
import 'package:stocktrack_flutter/src/supplier/domain/entities/supplier_request.dart';
import 'package:stocktrack_flutter/src/supplier/domain/entities/supplier_response.dart';
import 'package:stocktrack_flutter/src/supplier/domain/repos/supplier_repo.dart';

/// Represents a use case for fetching a list of suppliers.
///
/// This class extends [FutureUsecaseWithParams], specifying the response type
/// as [SupplierListResponse] and the parameter type as [SupplierListRequest].
class GetSuppliers
    extends FutureUsecaseWithParams<SupplierListResponse, SupplierListRequest> {
  /// Constructor for the [GetSuppliers] use case.
  ///
  /// Requires a [SupplierRepo] instance to interact with supplier repository.
  const GetSuppliers(this._repo);

  final SupplierRepo _repo;

  @override
  ResultFuture<SupplierListResponse> call(SupplierListRequest params) =>
      _repo.getSuppliers(params);
}
