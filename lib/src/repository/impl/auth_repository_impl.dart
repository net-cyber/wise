import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:wise/src/core/constants/app_constants.dart';
import 'package:wise/src/core/di/injection.dart';
import 'package:wise/src/core/handlers/handlers.dart';
import 'package:wise/src/model/login_response.dart';
import 'package:wise/src/model/user_model.dart';
import 'package:wise/src/presentation/pages/auth/login/riverpod/params/login_request_params.dart';
import 'package:wise/src/presentation/pages/auth/register/params/register_request_params.dart';
import 'package:wise/src/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<ApiResult<Unit>> register(RegisterRequestParams request) async {
      final data = {'email': request.email, 'password': request.password, 'name': request.name, 'username': request.userName};
      log('==> register data: $data');
       try {
      final client = inject<HttpService>().client(requireAuth: false);
      await client.post(
        '${AppConstants.baseUrl}/auth/register',
        data: data,
      );
      return const ApiResult.success(
        data: unit,
      );
    } catch (e) {
      debugPrint('==> register failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<LoginResponse>> login(LoginRequestParams request) async {
    final data = {'email': request.email, 'password': request.password};
    log('==> login data: $data');
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.post(
        '${AppConstants.baseUrl}/auth/login',
        data: data,
      );
      final loginResponse = LoginResponse.fromJson(response.data);
      return ApiResult.success(
        data: loginResponse,
      );
    } catch (e) {
      debugPrint('==> login failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<UserModel>> getUserDetails(BuildContext context) async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get('${AppConstants.baseUrl}/user');
      final user = UserModel.fromJson(response.data);
      return ApiResult.success(data: user);
    } catch (e) {
      debugPrint('==> get user details failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
