// ignore_for_file: avoid_positional_boolean_parameters

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stocktrack_flutter/core/res/constant.dart';

/// A service for managing data storage using `SharedPreferences`.
class StorageService {
  /// `SharedPreferences` is used for storing data key-value pair in the Android
  /// and iOS. `SharedPreference` let you read and write key-value pair in a
  /// couple of lines easily. But always remember, shared preference is not a
  /// solution for you to keep complex relational data.
  late final SharedPreferences _prefs;

  /// This should be working as a `Singleton`, This will make sure that
  /// your class has only one instance, and in this case `_prefs` is only
  /// instance that will have. But of course we'll have a global pointer to
  /// it and pointer would be covering when we globally initialize it.
  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  /// Saves a boolean value with the specified key.
  Future<bool> setBool(String key, bool value) async {
    return _prefs.setBool(key, value);
  }

  /// Saves a string value with the specified key.
  Future<bool> setString(String key, String value) async {
    return _prefs.setString(key, value);
  }

  /// Removes data associated with a specific key.
  Future<bool> remove(String key) {
    return _prefs.remove(key);
  }

  /// Checks if a user is logged in.
  bool getIsLoggedIn() {
    return _prefs.getString(AppConstants.STORAGE_USER_TOKEN_KEY) != null;
  }

  /// Retrieves the user's authentication token.
  String getUserToken() {
    return _prefs.getString(AppConstants.STORAGE_USER_TOKEN_KEY) ?? '';
  }

  bool getIsTokenExpired() {
    final token = _prefs.getString(AppConstants.STORAGE_USER_TOKEN_KEY) ?? '';
    if (token.isNotEmpty) {
      if (JwtDecoder.isExpired(token)) {
        return true;
      } else {
        return false;
      }
    }
    return true;
  }
}
