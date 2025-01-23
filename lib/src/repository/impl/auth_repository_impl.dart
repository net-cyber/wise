import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:wise/src/core/constants/app_constants.dart';
import 'package:wise/src/core/di/injection.dart';
import 'package:wise/src/core/handlers/handlers.dart';
import 'package:wise/src/presentation/pages/auth/login/riverpod/params/register_request_params.dart';
import 'package:wise/src/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<ApiResult<Unit>> register(RegisterRequestParams request) async {
      final data = {'email': request.email, 'password': request.password, 'name': request.name, 'username': request.userName};
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
}
