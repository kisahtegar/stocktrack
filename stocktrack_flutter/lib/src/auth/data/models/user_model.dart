import 'package:stocktrack_flutter/core/utils/typedefs.dart';
import 'package:stocktrack_flutter/src/auth/domain/entities/user.dart';

/// Represents a data model for a user login request.
class UserLoginRequestModel extends UserLoginRequest {
  /// Creates a `UserLoginRequestModel` instance with the provided `username`
  /// and `password`.
  const UserLoginRequestModel({
    required super.username,
    required super.password,
  });

  /// Creates an instance of `UserLoginRequestModel` with default or empty
  /// values for all properties. Useful for initializing an empty user model
  /// when needed.
  const UserLoginRequestModel.empty()
      : this(
          username: '',
          password: '',
        );

  /// Creates a new instance of `UserLoginRequestModel` with optional changes.
  UserLoginRequestModel copyWith({
    String? username,
    String? password,
  }) {
    return UserLoginRequestModel(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  /// Converts the `UserLoginRequestModel` to a JSON representation.
  DataMap toJson() => {
        'username': username,
        'password': password,
      };

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the `UserLoginRequestModel`.
  @override
  String toString() {
    return 'UserLoginRequestModel{username: $username, password: $password}';
  }
}

/// Represents a data model for a user login response.
class UserLoginResponseModel extends UserLoginResponse {
  /// Creates a `UserLoginResponseModel` instance with the provided `code`,
  /// `message`, and an optional `data`.
  const UserLoginResponseModel({
    required super.code,
    required super.message,
    super.data,
  });

  /// Creates a `UserLoginResponseModel` instance from a JSON representation.
  UserLoginResponseModel.fromJson(DataMap json)
      : super(
          code: json['code'] as String,
          message: json['message'] as String,
          data: UserLoginResponseDataModel.fromJson(json['data'] as DataMap),
        );

  /// Creates a new instance of `UserLoginResponseModel` with optional changes.
  UserLoginResponseModel copyWith({
    String? code,
    String? message,
    UserLoginResponseData? data,
  }) {
    return UserLoginResponseModel(
      code: code ?? this.code,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the `UserLoginResponseModel`.
  @override
  String toString() {
    return 'UserLoginResponseModel{code: $code, message: $message, '
        'data: $data}';
  }
}

/// Represents a data model for a user login response data.
class UserLoginResponseDataModel extends UserLoginResponseData {
  const UserLoginResponseDataModel({
    required super.token,
    required super.refreshToken,
  });

  /// Create a `UserLoginResponseDataModel` instance from a JSON representation.
  UserLoginResponseDataModel.fromJson(DataMap json)
      : super(
          token: json['token'] as String,
          refreshToken: json['refresh_token'] as String,
        );

  /// Creates a new instance of `UserLoginResponseDataModel` with optional
  /// changes.
  UserLoginResponseDataModel copyWith({
    String? token,
    String? refreshToken,
  }) {
    return UserLoginResponseDataModel(
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the `UserLoginResponseModel`.
  @override
  String toString() {
    return 'UserLoginResponseDataModel{token: $token, refreshToken: '
        '$refreshToken}';
  }
}

/// Represents a data model for a local user data.
class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required super.userId,
    required super.username,
    required super.fullName,
    required super.createdDate,
  });

  /// Creates a `LocalUserModel` instance from a JSON representation.
  LocalUserModel.fromJson(DataMap json)
      : super(
          userId: json['UserId'] as int,
          username: json['Username'] as String,
          fullName: json['FullName'] as String,
          createdDate: json['CreatedDate'] as DateTime,
        );

  /// Creates a new instance of `LocalUserModel` with optional changes.
  LocalUserModel copyWith({
    int? userId,
    String? username,
    String? fullName,
    DateTime? createdDate,
  }) {
    return LocalUserModel(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the `LocalUserModel`.
  @override
  String toString() {
    return 'LocalUserModel{userId: $userId, username: $username, fullName: '
        '$fullName, createdDate: $createdDate}';
  }
}
