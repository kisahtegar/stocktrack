import 'package:stocktrack_flutter/core/usecases/usecases.dart';
import 'package:stocktrack_flutter/core/utils/typedefs.dart';
import 'package:stocktrack_flutter/src/auth/domain/entities/user.dart';
import 'package:stocktrack_flutter/src/auth/domain/repos/auth_repo.dart';

/// The `SignIn` class represents a use case for user sign-in. It depends on an
/// `AuthRepo` instance to perform the actual sign-in operation.
class SignIn
    extends FutureUsecaseWithParams<UserLoginResponse, UserLoginRequest> {
  /// Initializes a new instance of the `SignIn` use case.
  ///
  /// [_repo] - The authentication repository (`AuthRepo`) responsible for
  /// handling user sign-in requests.
  const SignIn(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<UserLoginResponse> call(UserLoginRequest params) =>
      _repo.signIn(params);
}
