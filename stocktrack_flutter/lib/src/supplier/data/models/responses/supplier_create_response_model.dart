import 'dart:convert';

import 'package:stocktrack_flutter/core/utils/typedefs.dart';
import 'package:stocktrack_flutter/src/supplier/domain/entities/supplier_entity.dart';

/// Represent a concrete implementation of [SupplierCreateResponse] with
/// specific functionality and data transformation methods
class SupplierCreateResponseModel extends SupplierCreateResponse {
  /// Constructs a [SupplierCreateResponseModel] instance with the specified
  /// parameters.
  const SupplierCreateResponseModel({
    super.code,
    super.message,
    super.error,
  });

  /// Creates an empty [SupplierCreateResponseModel] instance with default
  /// values.
  const SupplierCreateResponseModel.empty()
      : this(
          code: '',
          message: '',
          error: '',
        );

  /// Factory method to create an [SupplierCreateResponseModel] from a
  /// JSON-encoded string.
  factory SupplierCreateResponseModel.fromJson(String source) =>
      SupplierCreateResponseModel.fromMap(jsonDecode(source) as DataMap);

  /// Constructs an [SupplierCreateResponseModel] from a map of data.
  SupplierCreateResponseModel.fromMap(DataMap map)
      : super(
          code: map['code'] as String,
          message: map['message'] as String,
          error: map['error'] as String?,
        );

  /// Create a new instance of [SupplierCreateResponseModel] with optional
  /// changes.
  SupplierCreateResponseModel copyWith({
    String? code,
    String? message,
    String? error,
  }) {
    return SupplierCreateResponseModel(
      code: code ?? this.code,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }

  /// Converts the [SupplierCreateResponseModel] to a JSON representation.
  DataMap toJson() => {
        'code': code,
        'message': message,
        'error': error,
      };

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the [SupplierCreateResponseModel] instance.
  @override
  String toString() {
    return 'SupplierCreateResponseModel{code: $code, message: $message, error: '
        '$error}';
  }
}
