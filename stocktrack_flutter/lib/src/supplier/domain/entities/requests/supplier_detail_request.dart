import 'package:equatable/equatable.dart';

/// Represents a request for fetching details of a specific supplier identified
/// by the supplier code.
class SupplierDetailRequest extends Equatable {
  /// Constructs a [SupplierDetailRequest] instance with the provided details.
  const SupplierDetailRequest({
    this.supplierCode,
  });

  /// The unique identifier for the supplier.
  final String? supplierCode;

  /// Overrides the `props` method to provide a list of object properties
  /// that should be considered when determining the equality of two
  /// `SupplierDetailRequest` instances.
  @override
  List<Object?> get props => [supplierCode];

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the `SupplierDetailRequest` instance.
  @override
  String toString() {
    return 'SupplierDetailRequest{supplierCode: $supplierCode';
  }
}
