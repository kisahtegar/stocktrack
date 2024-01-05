import 'package:stocktrack_flutter/core/utils/typedefs.dart';
import 'package:stocktrack_flutter/src/supplier/domain/entities/responses/supplier_item.dart';

/// Represent a concrete implementation of [SupplierItem] with specific
/// functionality and data transformation methods
class SupplierItemModel extends SupplierItem {
  /// Constructs a [SupplierItemModel] instance with the specified
  /// parameters.
  const SupplierItemModel({
    super.supplierId,
    super.supplierCode,
    super.supplierName,
    super.address,
    super.contact,
    super.isActive = 1,
  });

  /// Creates an empty [SupplierItemModel] instance with default
  /// values.
  const SupplierItemModel.empty()
      : this(
          supplierId: 0,
          supplierCode: '',
          supplierName: '',
          address: '',
          contact: '',
          isActive: 0,
        );

  /// Creates a `SupplierItemModel` instance from a JSON representation.
  SupplierItemModel.fromMap(DataMap map)
      : super(
          supplierId: map['supplier_id'] as int,
          supplierCode: map['supplier_code'] as String,
          supplierName: map['supplier_name'] as String,
          address: map['address'] as String,
          contact: map['contact'] as String,
          isActive: map['isActive'] as int?,
        );

  /// Create a new instance of [SupplierItemModel] with optional
  /// changes.
  SupplierItemModel copyWith({
    int? supplierId,
    String? supplierCode,
    String? supplierName,
    String? address,
    String? contact,
    int? isActive,
  }) {
    return SupplierItemModel(
      supplierId: supplierId ?? this.supplierId,
      supplierCode: supplierCode ?? this.supplierCode,
      supplierName: supplierName ?? this.supplierName,
      address: address ?? this.address,
      contact: contact ?? this.contact,
      isActive: isActive ?? this.isActive,
    );
  }

  /// Converts the [SupplierItemModel] to a JSON representation.
  DataMap toJson() => {
        'supplierId': supplierId,
        'supplierCode': supplierCode,
        'supplierName': supplierName,
        'address': address,
        'contact': contact,
        'isActive': isActive,
      };

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the [SupplierItemModel] instance.
  @override
  String toString() {
    return 'SupplierItemModel{supplierId: $supplierId, supplierCode: '
        '$supplierCode, supplierName: $supplierName, address: $address, '
        'contact: $contact, isActive: $isActive}';
  }
}
