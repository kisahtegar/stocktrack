import 'package:dartz/dartz.dart';
import 'package:stocktrack_flutter/core/errors/exceptions.dart';
import 'package:stocktrack_flutter/core/errors/failures.dart';
import 'package:stocktrack_flutter/core/utils/typedefs.dart';
import 'package:stocktrack_flutter/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:stocktrack_flutter/src/auth/domain/entities/user.dart';
import 'package:stocktrack_flutter/src/auth/domain/repos/auth_repo.dart';

/// Implementation of [AuthRepo] responsible for handling authentication
/// repository operations.
class AuthRepoImpl implements AuthRepo {
  /// Constructor to create an instance of [AuthRepoImpl].
  ///
  /// Requires an instance of [AuthRemoteDataSrc] as a parameter.
  AuthRepoImpl(this._remoteDataSource);

  /// Instance of [AuthRemoteDataSrc] used for remote data source operations.
  final AuthRemoteDataSrc _remoteDataSource;

  /// Performs user sign-in using the provided [userLoginRequest].
  ///
  /// Returns a [ResultFuture] wrapping [UserLoginResponse] on success,
  /// or a [Left] wrapping [ServerFailure] on failure.
  @override
  ResultFuture<UserLoginResponse> signIn(
    UserLoginRequest userLoginRequest,
  ) async {
    try {
      // Call the sign-in method on the remote data source
      final result = await _remoteDataSource.signIn(userLoginRequest);

      // Return the result wrapped in a Right
      return Right(result);
    } on ServerException catch (e) {
      // Handle ServerException and return a Left wrapping ServerFailure
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
