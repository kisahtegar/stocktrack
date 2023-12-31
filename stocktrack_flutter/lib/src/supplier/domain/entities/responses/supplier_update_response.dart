import 'package:equatable/equatable.dart';

/// Represents a response for updating an existing supplier.
class SupplierUpdateResponse extends Equatable {
  /// Constructs a [SupplierUpdateResponse] with the provided details.
  const SupplierUpdateResponse({
    this.code,
    this.message,
    this.error,
  });

  /// The HTTP status code of the response.
  final String? code;

  /// A message providing information about the response status.
  final String? message;

  /// An error message in case of an unsuccessful creation attempt.
  final String? error;

  /// Overrides the `props` method to provide a list of object properties
  /// that should be considered when determining the equality of two
  /// `SupplierUpdateResponse` instances.
  @override
  List<Object?> get props => [code, message, error];

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the `SupplierUpdateResponse` instance.
  @override
  String toString() {
    return 'SupplierUpdateResponse{code: $code, message: $message, data: $error'
        '}';
  }
}
