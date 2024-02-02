import 'package:equatable/equatable.dart';

/// Represents a request for deleting a supplier identified by the supplier
/// code.
class SupplierDeleteRequest extends Equatable {
  /// Constructs a [SupplierDeleteRequest] instance with the provided details.
  const SupplierDeleteRequest({
    this.supplierCode,
  });

  /// The unique identifier for the supplier to be deleted.
  final String? supplierCode;

  /// Overrides the `props` method to provide a list of object properties
  /// that should be considered when determining the equality of two
  /// `SupplierDeleteRequest` instances.
  @override
  List<Object?> get props => [supplierCode];

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the `SupplierDeleteRequest` instance.
  @override
  String toString() {
    return 'SupplierDeleteRequest{supplierCode: $supplierCode';
  }
}
