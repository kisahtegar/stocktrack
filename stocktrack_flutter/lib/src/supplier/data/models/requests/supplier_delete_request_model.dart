import 'package:stocktrack_flutter/core/utils/typedefs.dart';
import 'package:stocktrack_flutter/src/supplier/domain/entities/supplier_entity.dart';

/// Represent a concrete implementation of [SupplierDeleteRequest] with specific
/// functionality and data transformation methods
class SupplierDeleteRequestModel extends SupplierDeleteRequest {
  /// Constructs a [SupplierDeleteRequestModel] instance with the specified
  /// parameters.
  const SupplierDeleteRequestModel({
    super.supplierCode,
  });

  /// Creates an empty [SupplierDeleteRequestModel] instance with default
  /// values.
  const SupplierDeleteRequestModel.empty()
      : this(
          supplierCode: '',
        );

  /// Create a new instance of [SupplierDeleteRequestModel] with optional
  /// changes.
  SupplierDeleteRequestModel copyWith({
    String? supplierCode,
  }) {
    return SupplierDeleteRequestModel(
      supplierCode: supplierCode ?? this.supplierCode,
    );
  }

  /// Converts the [SupplierDeleteRequestModel] to a JSON representation.
  DataMap toJson() => {
        'supplierCode': supplierCode,
      };

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the [SupplierDeleteRequestModel] instance.
  @override
  String toString() {
    return 'SupplierDeleteRequestModel{supplierCode: $supplierCode}';
  }
}
