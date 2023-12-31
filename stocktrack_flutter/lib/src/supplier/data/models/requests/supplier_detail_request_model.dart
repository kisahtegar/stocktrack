import 'package:stocktrack_flutter/core/utils/typedefs.dart';
import 'package:stocktrack_flutter/src/supplier/domain/entities/supplier_entity.dart';

/// Represent a concrete implementation of [SupplierDetailRequest] with specific
/// functionality and data transformation methods
class SupplierDetailRequestModel extends SupplierDetailRequest {
  /// Constructs a [SupplierDetailRequestModel] instance with the specified
  /// parameters.
  const SupplierDetailRequestModel({
    super.supplierCode,
  });

  /// Creates an empty [SupplierDetailRequestModel] instance with default
  /// values.
  const SupplierDetailRequestModel.empty()
      : this(
          supplierCode: '',
        );

  /// Create a new instance of [SupplierDetailRequestModel] with optional
  /// changes.
  SupplierDetailRequestModel copyWith({
    String? supplierCode,
  }) {
    return SupplierDetailRequestModel(
      supplierCode: supplierCode ?? this.supplierCode,
    );
  }

  /// Converts the [SupplierDetailRequestModel] to a JSON representation.
  DataMap toJson() => {
        'supplierCode': supplierCode,
      };

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the [SupplierDetailRequestModel] instance.
  @override
  String toString() {
    return 'SupplierDetailRequestModel{supplierCode: $supplierCode}';
  }
}
