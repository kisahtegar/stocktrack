import 'dart:convert';

import 'package:stocktrack_flutter/core/utils/typedefs.dart';
import 'package:stocktrack_flutter/src/supplier/domain/entities/supplier_entity.dart';

/// Represent a concrete implementation of [SupplierUpdateResponse] with
/// specific functionality and data transformation methods
class SupplierUpdateResponseModel extends SupplierUpdateResponse {
  /// Constructs a [SupplierUpdateResponseModel] instance with the specified
  /// parameters.
  const SupplierUpdateResponseModel({
    super.code,
    super.message,
    super.error,
  });

  /// Creates an empty [SupplierUpdateResponseModel] instance with default
  /// values.
  const SupplierUpdateResponseModel.empty()
      : this(
          code: '',
          message: '',
          error: '',
        );

  /// Factory method to create an [SupplierUpdateResponseModel] from a
  /// JSON-encoded string.
  factory SupplierUpdateResponseModel.fromJson(String source) =>
      SupplierUpdateResponseModel.fromMap(jsonDecode(source) as DataMap);

  /// Constructs an [SupplierUpdateResponseModel] from a map of data.
  SupplierUpdateResponseModel.fromMap(DataMap map)
      : super(
          code: map['code'] as String,
          message: map['message'] as String,
          error: map['error'] as String,
        );

  /// Create a new instance of [SupplierUpdateResponseModel] with optional
  /// changes.
  SupplierUpdateResponseModel copyWith({
    String? code,
    String? message,
    String? error,
  }) {
    return SupplierUpdateResponseModel(
      code: code ?? this.code,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }

  /// Converts the [SupplierUpdateResponseModel] to a JSON representation.
  DataMap toJson() => {
        'code': code,
        'message': message,
        'error': error,
      };

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the [SupplierUpdateResponseModel] instance.
  @override
  String toString() {
    return 'SupplierUpdateResponseModel{code: $code, message: $message, error: '
        '$error}';
  }
}
