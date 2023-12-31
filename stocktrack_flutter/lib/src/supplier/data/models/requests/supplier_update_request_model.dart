import 'package:stocktrack_flutter/core/utils/typedefs.dart';
import 'package:stocktrack_flutter/src/supplier/domain/entities/supplier_entity.dart';

/// Represent a concrete implementation of [SupplierUpdateRequest] with specific
/// functionality and data transformation methods
class SupplierUpdateRequestModel extends SupplierUpdateRequest {
  /// Constructs a [SupplierUpdateRequestModel] instance with the specified
  /// parameters.
  const SupplierUpdateRequestModel({
    super.supplierId,
    super.supplierCode,
    super.supplierName,
    super.address,
    super.contact,
    super.isActive,
  });

  /// Creates an empty [SupplierUpdateRequestModel] instance with default
  /// values.
  const SupplierUpdateRequestModel.empty()
      : this(
          supplierId: 0,
          supplierCode: '',
          supplierName: '',
          address: '',
          contact: '',
          isActive: 0,
        );

  /// Create a new instance of [SupplierUpdateRequestModel] with optional
  /// changes.
  SupplierUpdateRequestModel copyWith({
    int? supplierId,
    String? supplierCode,
    String? supplierName,
    String? address,
    String? contact,
    int? isActive,
  }) {
    return SupplierUpdateRequestModel(
      supplierId: supplierId ?? this.supplierId,
      supplierCode: supplierCode ?? this.supplierCode,
      supplierName: supplierName ?? this.supplierName,
      address: address ?? this.address,
      contact: contact ?? this.contact,
      isActive: isActive ?? this.isActive,
    );
  }

  /// Converts the [SupplierUpdateRequestModel] to a JSON representation.
  DataMap toJson() => {
        'supplierId': supplierId,
        'supplierCode': supplierCode,
        'supplierName': supplierName,
        'address': address,
        'contact': contact,
        'isActive': isActive,
      };

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the [SupplierUpdateRequestModel] instance.
  @override
  String toString() {
    return 'SupplierUpdateRequestModel{supplierId: $supplierId, supplierCode: '
        '$supplierCode, supplierName: $supplierName, address: $address, '
        'contact: $contact, isActive: $isActive}';
  }
}
