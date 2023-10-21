// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: lines_longer_than_80_chars

import 'package:equatable/equatable.dart';

/// Represents a login request sent to the backend server.
class UserLoginRequest extends Equatable {
  /// Creates a `UserLoginRequest` with the provided `username` and `password`.
  const UserLoginRequest({
    required this.username,
    required this.password,
  });

  /// Creates an empty `UserLoginRequest` with blank `username` and `password`.
  const UserLoginRequest.empty()
      : username = '',
        password = '';

  /// The username used for authentication.
  final String username;

  /// The password used for authentication.
  final String password;

  /// Overrides the `props` method to provide a list of object properties that
  /// should be considered when determining the equality of two `UserLoginRequest`
  /// instances.
  @override
  List<Object?> get props => [username, password];

  /// Overrides the `toString()` method to provide a human-readable
  /// representation of the `UserLoginRequest` instance.
  @override
  String toString() {
    return 'UserLoginRequest{username: $username, password: $password}';
  }
}

/// Represents the complete response structure after a successful login.
class UserLoginResponse extends Equatable {
  /// Creates a `UserLoginResponse` with the provided `code`, `message`, `data`.
  const UserLoginResponse({
    required this.code,
    required this.message,
    this.data,
  });

  /// The response code.
  final String code;

  /// The response message.
  final String message;

  /// The data associated with the response, which typically includes the tokens.
  final UserLoginResponseData? data;

  /// Overrides the `props` method to provide a list of object properties that
  /// should be considered when determining the equality of two `UserLoginResponse`
  /// instances.
  @override
  List<Object?> get props => [code, message, data];

  /// Overrides the `toString()` method to provide a human-readable representation
  /// of the `UserLoginResponse` instance.
  @override
  String toString() {
    return 'UserLoginResponse{code: $code, message: $message, data: $data}';
  }
}

/// Represents the data associated with a `UserLoginResponse`.
class UserLoginResponseData extends Equatable {
  /// Creates a `UserLoginResponseData` with the provided `token` and `refreshToken`.
  const UserLoginResponseData({
    required this.token,
    required this.refreshToken,
  });

  /// The authentication token received upon successful login.
  final String token;

  /// The refresh token for authentication.
  final String refreshToken;

  /// Overrides the `props` method to provide a list of object properties that
  /// should be considered when determining the equality of two `UserLoginResponseData`
  /// instances.
  @override
  List<Object?> get props => [token, refreshToken];

  /// Overrides the `toString()` method to provide a human-readable representation
  /// of the `UserLoginResponseData` instance.
  @override
  String toString() {
    return 'UserLoginResponseData{token: $token, refreshToken: $refreshToken}';
  }
}

/// Represents a local user entity.
class LocalUser extends Equatable {
  /// Creates a `LocalUser` with the provided properties.
  const LocalUser({
    required this.userId,
    required this.username,
    required this.fullName,
    required this.createdDate,
  });

  /// The unique identifier for the user.
  final int userId;

  /// The username of the user.
  final String username;

  /// The full name of the user.
  final String fullName;

  /// The date when the user account was created.
  final DateTime createdDate;

  /// Overrides the `props` method to provide a list of object properties that
  /// should be considered when determining the equality of two `LocalUser` instances.
  @override
  List<Object?> get props => [userId, username, fullName, createdDate];

  @override
  String toString() {
    return 'LocalUser{userId: $userId, username: $username, fullName: '
        '$fullName, createdDate: $createdDate}';
  }
}
