import 'package:stocktrack_flutter/core/utils/typedefs.dart';
import 'package:stocktrack_flutter/src/auth/domain/entities/user.dart';

/// The `AuthRepo` interface defines a set of abstract methods that encapsulate
/// authentication-related functionality required by the application. Concrete
/// classes implementing this interface will provide the actual implementation
/// for these methods, allowing the application to interact with different data
/// sources while adhering to a consistent contract for authentication
/// operations.
abstract class AuthRepo {
  const AuthRepo();

  /// Performs user sign-in.
  ResultFuture<UserLoginResponse> signIn({
    required String username,
    required String password,
  });

  // ResultFuture<void> signOut();

  // ResultFuture<TokenRefreshResponse> refreshAccessToken(String refreshToken);
}
