import 'package:stocktrack_flutter/core/utils/typedefs.dart';
import 'package:stocktrack_flutter/src/supplier/domain/entities/supplier_entity.dart';

/// Represent a concrete implementation of [SupplierListRequest] with specific
/// functionality and data transformation methods
class SupplierListRequestModel extends SupplierListRequest {
  /// Constructs a [SupplierListRequestModel] instance with the specified
  /// parameters.
  const SupplierListRequestModel({
    super.page,
    super.limit,
    super.search,
  });

  /// Creates an empty [SupplierListRequestModel] instance with default values.
  const SupplierListRequestModel.empty()
      : this(
          page: 0,
          limit: 0,
          search: '',
        );

  /// Create a new instance of [SupplierListRequestModel] with optional changes.
  SupplierListRequestModel copyWith({
    int? page,
    int? limit,
    String? search,
  }) {
    return SupplierListRequestModel(
      page: page ?? this.page,
      limit: limit ?? this.limit,
      search: search ?? this.search,
    );
  }

  /// Converts the [SupplierListRequestModel] to a JSON representation.
  DataMap toJson() => {
        'page': page,
        'limit': limit,
        'search': search,
      };

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the [SupplierListRequestModel] instance.
  @override
  String toString() {
    return 'SupplierListRequestModel{page: $page, limit: $limit, search: '
        '$search}';
  }
}
