import 'dart:convert';

import 'package:stocktrack_flutter/core/utils/typedefs.dart';
import 'package:stocktrack_flutter/src/supplier/data/models/supplier_model.dart';
import 'package:stocktrack_flutter/src/supplier/domain/entities/supplier_entity.dart';

/// Represent a concrete implementation of [SupplierDetailResponse] with
/// specific functionality and data transformation methods
class SupplierDetailResponseModel extends SupplierDetailResponse {
  /// Constructs a [SupplierDetailResponseModel] instance with the specified
  /// parameters.
  const SupplierDetailResponseModel({
    super.code,
    super.message,
    super.data,
  });

  /// Creates an empty [SupplierDetailResponseModel] instance with default
  /// values.
  const SupplierDetailResponseModel.empty()
      : this(
          code: '',
          message: '',
          data: const SupplierItem(),
        );

  /// Factory method to create an [SupplierDetailResponseModel] from a
  /// JSON-encoded string.
  factory SupplierDetailResponseModel.fromJson(String source) =>
      SupplierDetailResponseModel.fromMap(jsonDecode(source) as DataMap);

  /// Constructs an [SupplierDetailResponseModel] from a map of data.
  SupplierDetailResponseModel.fromMap(DataMap map)
      : super(
          code: map['code'] as String,
          message: map['message'] as String,
          data: SupplierItemModel.fromMap(map['data'] as DataMap),
        );

  /// Create a new instance of [SupplierDetailResponseModel] with optional
  /// changes.
  SupplierDetailResponseModel copyWith({
    String? code,
    String? message,
    SupplierItem? data,
  }) {
    return SupplierDetailResponseModel(
      code: code ?? this.code,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  /// Converts the [SupplierDetailResponseModel] to a JSON representation.
  DataMap toJson() => {
        'code': code,
        'message': message,
        'data': data,
      };

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the [SupplierDetailResponseModel] instance.
  @override
  String toString() {
    return 'SupplierDetailResponseModel{code: $code, message: $message, data: '
        '$data}';
  }
}
