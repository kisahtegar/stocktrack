import 'package:equatable/equatable.dart';

/// Represents pagination data with details such as total data, total page,
/// current page, and limit.
class PaginationData extends Equatable {
  /// Constructs a [PaginationData] instance with the provided details.
  const PaginationData({
    this.totalData,
    this.totalPage,
    this.page,
    this.limit,
  });

  /// The total number of data entries available.
  final int? totalData;

  /// The total number of pages based on the available data and page limit.
  final int? totalPage;

  /// The current page being displayed.
  final int? page;

  /// The maximum number of entries per page.
  final int? limit;

  /// Overrides the `props` method to provide a list of object properties that
  /// should be considered when determining the equality of two `PaginationData`
  /// instances.
  @override
  List<Object?> get props => [totalData, totalPage, page, limit];

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the `PaginationData` instance.
  @override
  String toString() {
    return 'PaginationData{totalData: $totalData, totalPage: $totalPage, '
        'page: $page, limit: $limit}';
  }
}
