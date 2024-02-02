import 'package:stocktrack_flutter/core/utils/typedefs.dart';
import 'package:stocktrack_flutter/src/supplier/domain/entities/supplier_entity.dart';

/// Represent a concrete implementation of [SupplierCreateRequest] with specific
/// functionality and data transformation methods
class SupplierCreateRequestModel extends SupplierCreateRequest {
  /// Constructs a [SupplierCreateRequestModel] instance with the specified
  /// parameters.
  const SupplierCreateRequestModel({
    super.supplierCode,
    super.supplierName,
    super.address,
    super.contact,
    super.isActive,
  });

  /// Creates an empty [SupplierCreateRequestModel] instance with default
  /// values.
  const SupplierCreateRequestModel.empty()
      : this(
          supplierCode: '',
          supplierName: '',
          address: '',
          contact: '',
          isActive: 0,
        );

  /// Create a new instance of [SupplierCreateRequestModel] with optional
  /// changes.
  SupplierCreateRequestModel copyWith({
    String? supplierCode,
    String? supplierName,
    String? address,
    String? contact,
    int? isActive,
  }) {
    return SupplierCreateRequestModel(
      supplierCode: supplierCode ?? this.supplierCode,
      supplierName: supplierName ?? this.supplierName,
      address: address ?? this.address,
      contact: contact ?? this.contact,
      isActive: isActive ?? this.isActive,
    );
  }

  /// Converts the [SupplierCreateRequestModel] to a JSON representation.
  DataMap toJson() => {
        'supplierCode': supplierCode,
        'supplierName': supplierName,
        'address': address,
        'contact': contact,
        'isActive': isActive,
      };

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the [SupplierCreateRequestModel] instance.
  @override
  String toString() {
    return 'SupplierCreateRequestModel{supplierCode: $supplierCode, '
        'supplierName: $supplierName, address: $address, contact: $contact, '
        'isActive: $isActive}';
  }
}
