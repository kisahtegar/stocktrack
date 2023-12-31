import 'package:stocktrack_flutter/core/shared/entities/pagination_data.dart';
import 'package:stocktrack_flutter/core/utils/typedefs.dart';

/// Represent a concrete implementation of [PaginationDataModel] with specific
/// functionality and data transformation methods
class PaginationDataModel extends PaginationData {
  /// Constructs a [PaginationDataModel] instance with the specified parameters.
  const PaginationDataModel({
    super.totalData,
    super.totalPage,
    super.page,
    super.limit,
  });

  /// Creates an empty [PaginationDataModel] instance with default values.
  const PaginationDataModel.empty()
      : this(
          totalData: 0,
          totalPage: 0,
          page: 0,
          limit: 0,
        );

  /// Creates a `PaginationDataModel` instance from a JSON representation.
  PaginationDataModel.fromMap(DataMap map)
      : super(
          totalData: map['total_data'] as int,
          totalPage: map['total_page'] as int,
          page: map['page'] as int,
          limit: map['limit'] as int,
        );

  /// Create a new instance of [PaginationDataModel] with optional changes.
  PaginationDataModel copyWith({
    int? totalData,
    int? totalPage,
    int? page,
    int? limit,
  }) {
    return PaginationDataModel(
      totalData: totalData ?? this.totalData,
      totalPage: totalPage ?? this.totalPage,
      page: page ?? this.page,
      limit: limit ?? this.limit,
    );
  }

  /// Converts the [PaginationDataModel] to a JSON representation.
  DataMap toJson() => {
        'totalData': totalData,
        'totalPage': totalPage,
        'page': page,
        'limit': limit,
      };

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the [PaginationDataModel] instance.
  @override
  String toString() {
    return 'PaginationDataModel{totalData: $totalData, totalPage: $totalPage, '
        'page: $page, limit: $limit}';
  }
}
