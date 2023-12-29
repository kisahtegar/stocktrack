// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stocktrack_flutter/core/errors/dio_exception_handler.dart';
import 'package:stocktrack_flutter/core/errors/exceptions.dart';
import 'package:stocktrack_flutter/core/res/app_constants.dart';
import 'package:stocktrack_flutter/core/services/injection_container.dart';
import 'package:stocktrack_flutter/core/services/storage_service.dart';
import 'package:stocktrack_flutter/core/utils/http_util.dart';
import 'package:stocktrack_flutter/core/utils/typedefs.dart';
import 'package:stocktrack_flutter/src/auth/data/models/user_model.dart';
import 'package:stocktrack_flutter/src/auth/domain/entities/user.dart';

/// Abstract class defining the contract for authentication remote data source.
abstract class AuthRemoteDataSrc {
  const AuthRemoteDataSrc();

  /// Performs user sign-in using the provided [userLoginRequest].
  ///
  /// Throws a [ServerException] in case of errors.
  Future<UserLoginResponseModel> signIn(
    UserLoginRequest userLoginRequest,
  );
}

/// Implementation of [AuthRemoteDataSrc] responsible for handling
/// authentication requests to the remote server.
class AuthRemoteDataSrcImpl implements AuthRemoteDataSrc {
  const AuthRemoteDataSrcImpl();

  @override
  Future<UserLoginResponseModel> signIn(
    UserLoginRequest userLoginRequest,
  ) async {
    try {
      debugPrint('AuthRemoteDataSrc.signIn: Running...');

      // Perform an HTTP POST request to the sign-in endpoint
      final response = await sl<HttpUtil>().post(
        AppConstants.SIGNIN_ENDPOINT,
        data: jsonEncode({
          'username': userLoginRequest.username,
          'password': userLoginRequest.password,
        }),
      );

      // Parse the response into a UserLoginResponseModel
      final userLoginResponse = UserLoginResponseModel.fromJson(
        jsonDecode(response.toString()) as DataMap,
      );

      // Check if the response code indicates success. However, if response got
      // an error, it will go to DioException while perform an HTTP POST request
      if (userLoginResponse.code != '200') {
        throw ServerException(
          message: userLoginResponse.data.toString(),
          statusCode: userLoginResponse.code,
        );
      }

      // Save the user token to the local storage
      await sl<StorageService>().setString(
        AppConstants.STORAGE_USER_TOKEN_KEY,
        userLoginResponse.data!.token,
      );

      return userLoginResponse;
    } on ServerException {
      // Rethrow ServerException to propagate the error
      rethrow;
    } on DioException catch (e) {
      // Handle DioException using DioExceptionHandler
      DioExceptionHandler.handleError(e.response);
      // Rethrow DioException to propagate the error
      rethrow;
    } catch (e) {
      // Handle other exceptions and wrap them in a ServerException
      throw ServerException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }
}
