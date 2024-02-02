import 'package:equatable/equatable.dart';
import 'package:stocktrack_flutter/core/shared/entities/pagination_data.dart';
import 'package:stocktrack_flutter/src/supplier/domain/entities/responses/supplier_item.dart';

/// Represents a response containing a list of suppliers and pagination
/// information.
class SupplierListResponse extends Equatable {
  /// Constructs a [SupplierListResponse] with the provided details.
  const SupplierListResponse({
    this.code,
    this.message,
    this.data,
    this.paginationData,
  });

  /// The HTTP status code of the response.
  final String? code;

  /// A message providing information about the response status.
  final String? message;

  /// The list of [SupplierItem]s.
  final List<SupplierItem>? data;

  /// The pagination information for the list of suppliers.
  final PaginationData? paginationData;

  /// Overrides the `props` method to provide a list of object properties
  /// that should be considered when determining the equality of two
  /// `SupplierListResponse` instances.
  @override
  List<Object?> get props => [code, message, data, paginationData];

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the `SupplierListResponse` instance.
  @override
  String toString() {
    return 'SupplierListResponse{code: $code, message: $message, data: $data, '
        'paginationData: $paginationData}';
  }
}
