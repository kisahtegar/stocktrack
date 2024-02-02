import 'package:equatable/equatable.dart';

/// Represents a request for creating a new supplier with details such as code,
/// name, address, contact information, and active status.
class SupplierCreateRequest extends Equatable {
  /// Constructs a [SupplierCreateRequest] instance with the provided details.
  const SupplierCreateRequest({
    this.supplierCode,
    this.supplierName,
    this.address,
    this.contact,
    this.isActive,
  });

  /// The unique code for the new supplier.
  final String? supplierCode;

  /// The name of the new supplier.
  final String? supplierName;

  /// The address of the new supplier.
  final String? address;

  /// The contact information for the new supplier.
  final String? contact;

  /// The active status of the new supplier.
  final int? isActive;

  /// Overrides the `props` method to provide a list of object properties
  /// that should be considered when determining the equality of two
  /// `SupplierCreateRequest` instances.
  @override
  List<Object?> get props => [supplierCode];

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the `SupplierCreateRequest` instance.
  @override
  String toString() {
    return 'SupplierCreateRequest{supplierCode: $supplierCode, supplierName: '
        '$supplierName, address: $address, contact: $contact, isActive: '
        '$isActive}';
  }
}
