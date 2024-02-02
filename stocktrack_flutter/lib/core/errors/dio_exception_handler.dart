import 'package:dio/dio.dart';
import 'package:stocktrack_flutter/core/errors/exceptions.dart';

/// A utility class for handling Dio HTTP exceptions and converting them to
/// custom application-specific exceptions.
class DioExceptionHandler {
  /// Handles Dio HTTP exceptions and throws custom exceptions based on the
  /// response status code.
  ///
  /// - [response] : The Dio response containing information about the HTTP
  /// request.
  static void handleError(Response<dynamic>? response) {
    if (response != null) {
      final statusCode = response.statusCode;

      switch (statusCode) {
        // Handle 400 Bad Request
        case 400:
          throw const ServerException(
            message: 'User Not Found',
            statusCode: '404',
          );

        // Handle default case for unknown errors
        default:
          throw ServerException(
            message: response.statusMessage?.toString() ?? 'Unknown Error',
            statusCode: statusCode.toString(),
          );
      }
    } else {
      // Throw a custom exception for network errors or server unreachability
      throw const ServerException(
        message: 'Network error or server unreachable',
        statusCode: '500',
      );
    }
  }
}
