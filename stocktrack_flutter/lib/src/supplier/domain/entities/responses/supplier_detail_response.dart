import 'package:equatable/equatable.dart';
import 'package:stocktrack_flutter/src/supplier/domain/entities/responses/supplier_item.dart';

/// Represents a response containing details of a specific supplier.
class SupplierDetailResponse extends Equatable {
  /// Constructs a [SupplierDetailResponse] with the provided details.
  const SupplierDetailResponse({
    this.code,
    this.message,
    this.data,
  });

  /// The HTTP status code of the response.
  final String? code;

  /// A message providing information about the response status.
  final String? message;

  /// The details of a specific supplier.
  final SupplierItem? data;

  /// Overrides the `props` method to provide a list of object properties
  /// that should be considered when determining the equality of two
  /// `SupplierDetailResponse` instances.
  @override
  List<Object?> get props => [code, message, data];

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the `SupplierDetailResponse` instance.
  @override
  String toString() {
    return 'SupplierDetailResponse{code: $code, message: $message, data: $data'
        '}';
  }
}
