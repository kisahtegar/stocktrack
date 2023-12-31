import 'package:equatable/equatable.dart';

/// Represents a supplier entity with details such as ID, code, name, address,
/// contact information, and active status.
class SupplierItem extends Equatable {
  /// Constructs a [SupplierItem] with the provided details.
  const SupplierItem({
    this.supplierId,
    this.supplierCode,
    this.supplierName,
    this.address,
    this.contact,
    this.isActive,
  });

  /// The unique identifier for the supplier.
  final int? supplierId;

  /// The unique code assigned to the supplier.
  final String? supplierCode;

  /// The name of the supplier.
  final String? supplierName;

  /// The address of the supplier.
  final String? address;

  /// The contact information for the supplier.
  final String? contact;

  /// The active status of the supplier.
  final int? isActive;

  /// Overrides the `props` method to provide a list of object properties that
  /// should be considered when determining the equality of two `SupplierItem`
  /// instances.
  @override
  List<Object?> get props => [supplierId];

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the `SupplierItem` instance.
  @override
  String toString() {
    return 'SupplierItem{supplierId: $supplierId, supplierCode: $supplierCode,'
        ' supplierName: $supplierName, address: $address, contact: $contact}';
  }
}
