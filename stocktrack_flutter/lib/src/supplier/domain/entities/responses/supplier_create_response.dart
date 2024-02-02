import 'package:equatable/equatable.dart';

/// Represents a response for creating a new supplier.
class SupplierCreateResponse extends Equatable {
  /// Constructs a [SupplierCreateResponse] with the provided details.
  const SupplierCreateResponse({
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
  /// `SupplierCreateResponse` instances.
  @override
  List<Object?> get props => [code, message, error];

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the `SupplierCreateResponse` instance.
  @override
  String toString() {
    return 'SupplierCreateResponse{code: $code, message: $message, data: $error'
        '}';
  }
}
