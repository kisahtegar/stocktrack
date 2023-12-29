// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stocktrack_flutter/core/errors/exceptions.dart';
import 'package:stocktrack_flutter/core/res/constant.dart';
import 'package:stocktrack_flutter/core/services/injection_container.dart';
import 'package:stocktrack_flutter/core/services/storage_service.dart';
import 'package:stocktrack_flutter/core/utils/http_util.dart';
import 'package:stocktrack_flutter/core/utils/typedefs.dart';
import 'package:stocktrack_flutter/src/auth/data/models/user_model.dart';
import 'package:stocktrack_flutter/src/auth/domain/entities/user.dart';

abstract class AuthRemoteDataSrc {
  const AuthRemoteDataSrc();

  Future<UserLoginResponseModel> signIn(
    UserLoginRequest userLoginRequest,
  );
}

class AuthRemoteDataSrcImpl implements AuthRemoteDataSrc {
  const AuthRemoteDataSrcImpl();

  @override
  Future<UserLoginResponseModel> signIn(
    UserLoginRequest userLoginRequest,
  ) async {
    try {
      debugPrint('AuthRemoteDataSrc.signIn: Running...');
      // Access the custom Dio instance from HttpUtil
      final dio = sl<HttpUtil>();

      final response = await dio.post(
        AppConstants.SIGNIN_ENDPOINT,
        data: jsonEncode({
          'username': userLoginRequest.username,
          'password': userLoginRequest.password,
        }),
      );

      final userLoginResponse = UserLoginResponseModel.fromJson(
        jsonDecode(response.toString()) as DataMap,
      );

      debugPrint('AuthRemoteDataSrc.signIn: response($response)');

      if (userLoginResponse.code != '2000200') {
        throw ServerException(
          message: userLoginResponse.data.toString(),
          statusCode: userLoginResponse.code,
        );
      }

      await sl<StorageService>().setString(
        AppConstants.STORAGE_USER_TOKEN_KEY,
        userLoginResponse.data!.token,
      );

      return userLoginResponse;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }
}
