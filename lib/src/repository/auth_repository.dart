import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:wise/src/core/handlers/handlers.dart';
import 'package:wise/src/model/login_response.dart';
import 'package:wise/src/model/user_model.dart';
import 'package:wise/src/presentation/pages/auth/login/riverpod/params/login_request_params.dart';
import 'package:wise/src/presentation/pages/auth/register/params/register_request_params.dart';

abstract class AuthRepository {
  Future<ApiResult<Unit>> register(RegisterRequestParams request);
  Future<ApiResult<LoginResponse>> login(LoginRequestParams request);
  Future<ApiResult<UserModel>> getUserDetails(BuildContext context);
}

