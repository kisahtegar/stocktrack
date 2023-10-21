import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stocktrack_flutter/core/errors/exceptions.dart';
import 'package:stocktrack_flutter/core/utils/constants.dart';
import 'package:stocktrack_flutter/core/utils/typedefs.dart';
import 'package:stocktrack_flutter/src/auth/data/models/user_model.dart';

// Endpoint
const kSignInEndpoint = '/api/v1/user/login';

// Shared preferences
const kUserTokenKey = 'user_token_key';

abstract class AuthRemoteDataSrc {
  const AuthRemoteDataSrc();

  Future<UserLoginResponseModel> signIn({
    required String username,
    required String password,
  });
}

class AuthRemoteDataSrcImpl implements AuthRemoteDataSrc {
  const AuthRemoteDataSrcImpl({
    required http.Client client,
    required SharedPreferences sharedPreferences,
  })  : _client = client,
        _sharedPreferences = sharedPreferences;

  final http.Client _client;
  final SharedPreferences _sharedPreferences;

  @override
  Future<UserLoginResponseModel> signIn({
    required String username,
    required String password,
  }) async {
    try {
      final uri = Uri.http('127.0.0.1:8081', kSignInEndpoint);

      final response = await _client.post(
        uri,
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      debugPrint('AuthRemoteDataSrcImpl(SignIn): here2');

      debugPrint('AuthRemoteDataSrcImpl(SignIn): $response');

      if (response.statusCode != 200) {
        print('Server Error: ${response.statusCode}');
        print('Response Body: ${response.body}');
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode.toString(),
        );
      }

      final responseData = jsonDecode(response.body) as DataMap;
      final userLoginResponse = UserLoginResponseModel.fromJson(responseData);

      // Save the user token to shared preferences
      await _sharedPreferences.setString(
        kUserTokenKey,
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
