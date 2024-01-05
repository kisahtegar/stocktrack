import 'dart:convert';

import 'package:stocktrack_flutter/core/shared/entities/pagination_data.dart';
import 'package:stocktrack_flutter/core/shared/models/pagination_data_model.dart';
import 'package:stocktrack_flutter/core/utils/typedefs.dart';
import 'package:stocktrack_flutter/src/supplier/data/models/supplier_model.dart';
import 'package:stocktrack_flutter/src/supplier/domain/entities/supplier_entity.dart';

/// Represent a concrete implementation of [SupplierListResponse] with specific
/// functionality and data transformation methods
class SupplierListResponseModel extends SupplierListResponse {
  /// Constructs a [SupplierListResponseModel] instance with the specified
  /// parameters.
  const SupplierListResponseModel({
    super.code,
    super.message,
    super.data,
    super.paginationData,
  });

  /// Creates an empty [SupplierListResponseModel] instance with default
  /// values.
  SupplierListResponseModel.empty()
      : this(
          code: '',
          message: '',
          data: [],
          paginationData: const PaginationData(),
        );

  /// Factory method to create an [SupplierListResponseModel] from a
  /// JSON-encoded string.
  factory SupplierListResponseModel.fromJson(String source) =>
      SupplierListResponseModel.fromMap(jsonDecode(source) as DataMap);

  /// Constructs an [SupplierListResponseModel] from a map of data.
  SupplierListResponseModel.fromMap(DataMap map)
      : super(
          code: map['code'] as String,
          message: map['message'] as String,
          data: map['data'] == null
              ? <SupplierItem>[]
              : List<SupplierItemModel>.from(
                  (map['data'] as List<dynamic>).map(
                    (x) => SupplierItemModel.fromMap(x as DataMap),
                  ),
                ),
          paginationData:
              PaginationDataModel.fromMap(map['pagination_data'] as DataMap),
        );

  /// Create a new instance of [SupplierListResponseModel] with optional
  /// changes.
  SupplierListResponseModel copyWith({
    String? code,
    String? message,
    List<SupplierItem>? data,
    PaginationData? paginationData,
  }) {
    return SupplierListResponseModel(
      code: code ?? this.code,
      message: message ?? this.message,
      data: data ?? this.data,
      paginationData: paginationData ?? this.paginationData,
    );
  }

  /// Converts the [SupplierListResponseModel] to a JSON representation.
  DataMap toJson() => {
        'code': code,
        'message': message,
        'data': data,
        'paginationData': paginationData,
      };

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the [SupplierListResponseModel] instance.
  @override
  String toString() {
    return 'SupplierListResponseModel{code: $code, message: $message, data: '
        '$data, paginationData: $paginationData, }';
  }
}
