// ignore_for_file: constant_identifier_names

/// A class containing constant values used throughout the application.
class AppConstants {
  /// The URL of the server's API.
  static const String SERVER_API_URL = 'http://127.0.0.1:8081';

  // Example of using ngrok for testing:
  // static const String SERVER_API_URL = ' https://4ad4-111-94-125-180.ngrok-free.app/';

  /// The endpoint for the user sign-in API.
  static const String SIGNIN_ENDPOINT = '/api/v1/user/login';

  /// The storage key for the user token.
  static const String STORAGE_USER_TOKEN_KEY = 'user_token_key';
}
