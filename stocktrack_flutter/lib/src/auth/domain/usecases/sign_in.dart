import 'package:equatable/equatable.dart';
import 'package:stocktrack_flutter/core/usecases/usecases.dart';
import 'package:stocktrack_flutter/core/utils/typedefs.dart';
import 'package:stocktrack_flutter/src/auth/domain/entities/user.dart';
import 'package:stocktrack_flutter/src/auth/domain/repos/auth_repo.dart';

/// The `SignIn` class represents a use case for user sign-in. It depends on an
/// `AuthRepo` instance to perform the actual sign-in operation.
class SignIn extends FutureUsecaseWithParams<UserLoginResponse, SignInParams> {
  /// Initializes a new instance of the `SignIn` use case.
  ///
  /// [_repo] - The authentication repository (`AuthRepo`) responsible for
  /// handling user sign-in requests.
  const SignIn(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<UserLoginResponse> call(SignInParams params) => _repo.signIn(
        username: params.username,
        password: params.password,
      );
}

/// The `SignInParams` class defines the required parameters for user sign-in,
/// including username and password. It can be used to create instances of these
/// parameters for invoking the sign-in use case.
class SignInParams extends Equatable {
  /// Initializes a new instance of `SignInParams` with the provided username
  /// and password.
  ///
  /// - [username] - The user's username for authentication.
  /// - [password] - The user's password for authentication.
  const SignInParams({
    required this.username,
    required this.password,
  });

  /// Creates an instance of `SignInParams` with default or empty values for
  /// username and password. This is useful for initializing an empty sign-in
  /// parameters object when needed.
  const SignInParams.empty()
      : username = '',
        password = '';

  final String username;
  final String password;

  @override
  List<String> get props => [username, password];
}
