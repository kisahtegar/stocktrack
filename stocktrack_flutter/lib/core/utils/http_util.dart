import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:stocktrack_flutter/core/res/constant.dart';
import 'package:stocktrack_flutter/core/services/injection_container.dart';
import 'package:stocktrack_flutter/core/services/storage_service.dart';

/// A utility class for making HTTP requests to the server using Dio.
class HttpUtil {
  /// Factory constructor for creating a singleton instance of HttpUtil.
  factory HttpUtil() {
    return _instance;
  }

  /// Initializes the HttpUtil with default options.
  HttpUtil._internal() {
    final options = BaseOptions(
      baseUrl: AppConstants.SERVER_API_URL,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {},
      contentType: 'application/json; charset=utf-8',
    );
    // Initialize Dio with the provided options
    dio = Dio(options);
  }

  // Singleton instance of HttpUtil
  static final HttpUtil _instance = HttpUtil._internal();

  late Dio dio;

  /// Sends an HTTP POST request to the server.
  ///
  /// - [path] - The API endpoint path.
  /// - [data] - The request body data.
  /// - [queryParameters] - Query parameters to be included in the request.
  /// - [options] - Additional options for the request.
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final requestOptions = options ?? Options();

    // If headers are not provided, initialize an empty map.
    requestOptions.headers = requestOptions.headers ?? {};

    // Add authorization header if available.
    final authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }

    // Send the POST request to the server.
    // ignore: inference_failure_on_function_invocation
    final response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
    );

    // Debug print status code and response data.
    debugPrint('HTTP Status Code: ${response.statusCode}');
    debugPrint('Response Data: $response');

    // Return the actual data received from the backend.
    return response;
  }

  /// Gets the authorization header containing the user access token.
  Map<String, dynamic>? getAuthorizationHeader() {
    final headers = <String, dynamic>{};
    final accessToken = sl<StorageService>().getUserToken();

    if (accessToken.isNotEmpty) {
      // Include the user access token in the Authorization header.
      headers['Authorization'] = 'Bearer $accessToken';
    }
    return headers;
  }
}
