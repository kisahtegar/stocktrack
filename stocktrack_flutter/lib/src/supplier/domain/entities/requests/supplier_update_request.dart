import 'package:equatable/equatable.dart';

/// Represents a request for updating an existing supplier identified by the
/// supplier ID, with details such as code, name, address, contact information,
/// and active status.
class SupplierUpdateRequest extends Equatable {
  /// Constructs a [SupplierUpdateRequest] instance with the provided details.
  const SupplierUpdateRequest({
    this.supplierId,
    this.supplierCode,
    this.supplierName,
    this.address,
    this.contact,
    this.isActive,
  });

  /// The unique identifier for the existing supplier.
  final int? supplierId;

  /// The unique code for the supplier.
  final String? supplierCode;

  /// The updated name of the supplier.
  final String? supplierName;

  /// The updated address of the supplier.
  final String? address;

  /// The updated contact information for the supplier.
  final String? contact;

  /// The updated active status of the supplier.
  final int? isActive;

  /// Overrides the `props` method to provide a list of object properties
  /// that should be considered when determining the equality of two
  /// `SupplierUpdateRequest` instances.
  @override
  List<Object?> get props => [supplierId];

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the `SupplierUpdateRequest` instance.
  @override
  String toString() {
    return 'SupplierUpdateRequest{supplierId: $supplierId, supplierCode: '
        '$supplierCode,supplierName: $supplierName, address: $address, '
        'contact: $contact, isActive: $isActive}';
  }
}
