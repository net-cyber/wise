import 'package:dartz/dartz.dart';
import 'package:wise/src/core/handlers/handlers.dart';
import 'package:wise/src/presentation/pages/auth/login/riverpod/params/register_request_params.dart';

abstract class AuthRepository {
  Future<ApiResult<Unit>> register(RegisterRequestParams request);
}

