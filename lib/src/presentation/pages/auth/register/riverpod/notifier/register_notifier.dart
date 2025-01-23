import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wise/src/core/handlers/app_connectivity.dart';
import 'package:wise/src/core/router/route_name.dart';
import 'package:wise/src/core/validators/string_validators.dart';
import 'package:wise/src/core/validators/validation_mixin.dart';
import 'package:wise/src/presentation/pages/auth/login/riverpod/params/register_request_params.dart';
import 'package:wise/src/presentation/pages/initial/onboarding/widget/buttons/authentication_buttons.dart';
import 'package:wise/src/repository/auth_repository.dart';

import '../../../../../../core/handlers/network_exceptions.dart';
import '../../../../../../core/utils/app_helpers.dart';
import '../../../../../../core/validators/validation_pipe.dart';
import '../state/register_state.dart';

class RegisterNotifier extends StateNotifier<RegisterState>  with ValidationMixin{
  final AuthRepository _authRepository;


  RegisterNotifier(
    this._authRepository,
  ) : super(const RegisterState()){
        // Setup validation pipes
    addValidationPipe('email', ValidationPipe([
      RequiredValidator(),
      EmailValidator(),

    ]));
    
    addValidationPipe('password', ValidationPipe([
      RequiredValidator(),
      MinLengthValidator(8),
    ]));

    addValidationPipe('name', ValidationPipe([
      RequiredValidator(),
      MinLengthValidator(3),
    ]));

    addValidationPipe('userName', ValidationPipe([
      RequiredValidator(),
      MinLengthValidator(3),
    ]));

    addValidationPipe('confirmPassword', ValidationPipe([
      RequiredValidator(),
      MinLengthValidator(8),
      // add the password current field
      MatchValidator(state.password),
    ]));
  }

  void setPassword(String password) {
    state = state.copyWith(password: password.trim(), isPasswordInvalid: false);
  }

  void setConfirmPassword(String password) {
    state = state.copyWith(
      confirmPassword: password.trim(),
      isConfirmPasswordInvalid: false,
    );
  }

  void setFirstName(String name) {
    state = state.copyWith(name: name.trim());
  }

  void setEmail(String value) {
    state = state.copyWith(email: value.trim(), isEmailInvalid: false);
  }

  void setUserName(String name) {
    state = state.copyWith(userName: name.trim());
  }

  void toggleShowPassword() {
    state = state.copyWith(showPassword: !state.showPassword);
  }

  void toggleShowConfirmPassword() {
    state = state.copyWith(showConfirmPassword: !state.showConfirmPassword);
  }

  Future<void> register(BuildContext context) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      final errors = validateAll(
        {
          'email': state.email,
          'password': state.password,
          'confirmPassword': state.confirmPassword,
          'name': state.name,
          'userName': state.userName,
        }
      );
      if (errors.isNotEmpty) {
        state = state.copyWith(
          isLoading: false,
          validationErrors: errors,
        );
        return;
      }
      state = state.copyWith(isLoading: true);
      RegisterRequestParams request = RegisterRequestParams(
       
        email: state.email,
        password: state.password,
       
        name: state.name,
        userName: state.userName,
      );
      final response = await _authRepository.register(request);
      
      response.when(
        success: (data) async {
          state = state.copyWith(isLoading: false);
         
          context.goNamed(RouteName.login);
        },
        failure: (failure) {
          state = state.copyWith(isLoading: false);
          final errorMessage = NetworkExceptions.getErrorMessage(failure);
          AppHelpers.showCheckFlash(
            context,
            errorMessage,
          );
          debugPrint('==> register failure: $failure');
        },
      );
    } else {
      if (mounted) {
        AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }
}
