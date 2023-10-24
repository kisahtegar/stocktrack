import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:stocktrack_flutter/src/auth/data/models/user_model.dart';

/// A provider class to manage user-related data and authentication token.
class UserProvider extends ChangeNotifier {
  LocalUserModel? _user;
  String? _usertoken;

  /// Gets the current user information.
  LocalUserModel? get user => _user;

  /// Gets the user's authentication token.
  String? get userToken => _usertoken;

  /// Initializes the user with the provided user data.
  void initUser(LocalUserModel? user) {
    if (_user != user) _user = user;
  }

  /// Initializes the user's authentication token.
  void initUserToken(String? userToken) {
    if (_usertoken != userToken) {
      _usertoken = userToken;
    }
  }

  /// Sets the user data and triggers a notification to update the UI.
  set user(LocalUserModel? user) {
    if (_user != user) {
      _user = user;
      notifyListeners();
    }
  }

  /// Sets the user authentication token and notifies listeners.
  set userToken(String? userToken) {
    if (_usertoken != userToken) {
      _usertoken = userToken;
      notifyListeners();
    }
  }
}
