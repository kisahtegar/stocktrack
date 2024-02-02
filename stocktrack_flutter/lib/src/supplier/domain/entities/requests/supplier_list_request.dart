import 'package:equatable/equatable.dart';

/// Represents a request for fetching a list of suppliers with optional
/// parameters such as page, limit, and search criteria.
class SupplierListRequest extends Equatable {
  /// Constructs a [SupplierListRequest] instance with the provided details.
  const SupplierListRequest({
    this.page,
    this.limit,
    this.search,
  });

  /// The page number for paginated results.
  final int? page;

  /// The maximum number of items to return per page.
  final int? limit;

  /// Search criteria to filter the list of suppliers.
  final String? search;

  /// Overrides the `props` method to provide a list of object properties
  /// that should be considered when determining the equality of two
  /// `SupplierListRequest` instances.
  @override
  List<Object?> get props => [page, limit, search];

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the `SupplierListRequest` instance.
  @override
  String toString() {
    return 'SupplierListRequest{page: $page, limit: $limit, search: $search}';
  }
}
