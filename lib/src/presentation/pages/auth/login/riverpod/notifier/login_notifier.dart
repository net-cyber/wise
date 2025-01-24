import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wise/src/core/handlers/app_connectivity.dart';
import 'package:wise/src/core/handlers/network_exceptions.dart';
import 'package:wise/src/core/router/route_name.dart';
import 'package:wise/src/core/utils/app_helpers.dart';
import 'package:wise/src/core/utils/local_storage.dart';
import 'package:wise/src/core/validators/string_validators.dart';
import 'package:wise/src/core/validators/validation_mixin.dart';
import 'package:wise/src/core/validators/validation_pipe.dart';
import 'package:wise/src/presentation/pages/auth/login/riverpod/params/login_request_params.dart';
import 'package:wise/src/presentation/pages/auth/login/riverpod/state/login_state.dart';
import 'package:wise/src/repository/auth_repository.dart';

class LoginNotifier extends StateNotifier<LoginState> with ValidationMixin {
  LoginNotifier(this.authRepository) : super(const LoginState()){
            // Setup validation pipes
    addValidationPipe('email', ValidationPipe([
      RequiredValidator(),
      EmailValidator(),

    ]));
    
    addValidationPipe('password', ValidationPipe([
      RequiredValidator(),
      MinLengthValidator(8),
    ]));

  }

  final AuthRepository authRepository;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

    void setPassword(String password) {
    log('==> setPassword called with: $password');
    final result = validateField('password', password);
    log('==> password: $password');
    if (!result.isValid && result.error != null) {
      state = state.copyWith(password: password.trim(), isPasswordNotValid: true, validationErrors: {
        'password': result.error!,
      });
    } else {
      state = state.copyWith(password: password.trim(), isPasswordNotValid: false);
    }
  }


  void setEmail(String value) {
    final result = validateField('email', value);
    log('==> email: $value');
    if (!result.isValid && result.error != null) {
      state = state.copyWith(email: value.trim(), isEmailNotValid: true, validationErrors: {
        'email': result.error!,
      });
    } else {
      state = state.copyWith(email: value.trim(), isEmailNotValid: false, );
    }
  }

    void toggleShowPassword() {
    log('==> showPassword: ${!state.showPassword}');
    state = state.copyWith(showPassword: !state.showPassword);
  }
  bool get isFormValid {
    if (state.email.isEmpty || state.password.isEmpty) {
      return false;
    }
    if (state.isEmailNotValid || state.isPasswordNotValid) {
      return false;
    }
    return true;
  }

  Future<void> login(BuildContext context) async {
    final connected = await AppConnectivity.connectivity();
 
      final errors = validateAll(
        {
          'email': state.email,
          'password': state.password,
        }
      );
      if (errors.isNotEmpty) {
        state = state.copyWith(
          isLoading: false,
          validationErrors: errors,
        );
        return;
      }
    if (!connected) {
      AppHelpers.showCheckFlash(context, 'No internet connection');
      return;
    }
    state = state.copyWith(isLoading: true);
    final result = await authRepository.login(LoginRequestParams(email: state.email, password: state.password));
    result.when(
      success: (data) {
        LocalStorage.instance.setAccessToken(data.accessToken);
        LocalStorage.instance.setRefreshToken(data.refreshToken);
        // clear text fields
        emailController.clear();
        passwordController.clear();

        state = state.copyWith(isLoading: false);
        context.goNamed(RouteName.home);
      },
      failure: (failure) {
        state = state.copyWith(isLoading: false);
        final errorMessage = NetworkExceptions.getErrorMessage(failure);
        AppHelpers.showCheckFlash(
            context,
            errorMessage,
          );
      },
    );
  }

  void logout(BuildContext context) {
    LocalStorage.instance.deleteAccessToken();
    LocalStorage.instance.deleteRefreshToken();
    context.goNamed(RouteName.onboarding);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
