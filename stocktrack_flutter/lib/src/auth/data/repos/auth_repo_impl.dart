import 'package:dartz/dartz.dart';
import 'package:stocktrack_flutter/core/errors/exceptions.dart';
import 'package:stocktrack_flutter/core/errors/failures.dart';
import 'package:stocktrack_flutter/core/utils/typedefs.dart';
import 'package:stocktrack_flutter/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:stocktrack_flutter/src/auth/domain/entities/user.dart';
import 'package:stocktrack_flutter/src/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl(this._remoteDataSource);

  final AuthRemoteDataSrc _remoteDataSource;

  @override
  ResultFuture<UserLoginResponse> signIn(
    UserLoginRequest userLoginRequest,
  ) async {
    try {
      final result = await _remoteDataSource.signIn(userLoginRequest);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
