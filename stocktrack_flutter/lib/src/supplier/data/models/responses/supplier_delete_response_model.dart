import 'dart:convert';

import 'package:stocktrack_flutter/core/utils/typedefs.dart';
import 'package:stocktrack_flutter/src/supplier/domain/entities/supplier_entity.dart';

/// Represent a concrete implementation of [SupplierDeleteResponse] with
/// specific functionality and data transformation methods
class SupplierDeleteResponseModel extends SupplierDeleteResponse {
  /// Constructs a [SupplierDeleteResponseModel] instance with the specified
  /// parameters.
  const SupplierDeleteResponseModel({
    super.code,
    super.message,
    super.error,
  });

  /// Creates an empty [SupplierDeleteResponseModel] instance with default
  /// values.
  const SupplierDeleteResponseModel.empty()
      : this(
          code: '',
          message: '',
          error: '',
        );

  /// Factory method to create an [SupplierDeleteResponseModel] from a
  /// JSON-encoded string.
  factory SupplierDeleteResponseModel.fromJson(String source) =>
      SupplierDeleteResponseModel.fromMap(jsonDecode(source) as DataMap);

  /// Constructs an [SupplierDeleteResponseModel] from a map of data.
  SupplierDeleteResponseModel.fromMap(DataMap map)
      : super(
          code: map['code'] as String,
          message: map['message'] as String,
          error: map['error'] as String,
        );

  /// Create a new instance of [SupplierDeleteResponseModel] with optional
  /// changes.
  SupplierDeleteResponseModel copyWith({
    String? code,
    String? message,
    String? error,
  }) {
    return SupplierDeleteResponseModel(
      code: code ?? this.code,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }

  /// Converts the [SupplierDeleteResponseModel] to a JSON representation.
  DataMap toJson() => {
        'code': code,
        'message': message,
        'error': error,
      };

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the [SupplierDeleteResponseModel] instance.
  @override
  String toString() {
    return 'SupplierDeleteResponseModel{code: $code, message: $message, error: '
        '$error}';
  }
}
