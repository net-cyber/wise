import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wise/src/core/handlers/app_connectivity.dart';
import 'package:wise/src/core/router/route_name.dart';
import 'package:wise/src/core/validators/string_validators.dart';
import 'package:wise/src/core/validators/validation_mixin.dart';
import 'package:wise/src/presentation/pages/auth/register/params/register_request_params.dart';
import 'package:wise/src/presentation/pages/initial/onboarding/widget/buttons/authentication_buttons.dart';
import 'package:wise/src/repository/auth_repository.dart';

import '../../../../../../core/handlers/network_exceptions.dart';
import '../../../../../../core/utils/app_helpers.dart';
import '../../../../../../core/validators/validation_pipe.dart';
import '../state/register_state.dart';

class RegisterNotifier extends StateNotifier<RegisterState>  with ValidationMixin{
  final AuthRepository _authRepository;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  RegisterNotifier(
    this._authRepository,
  ) : super(const RegisterState()){
      log('==> RegisterNotifier called with: ${state.password}');

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
  }

  ValidationPipe<String> _getConfirmPasswordValidationPipe() {
    return ValidationPipe([
      MatchValidator(state.password),
      RequiredValidator(),
      MinLengthValidator(8),
    ]);
  }

  void setPassword(String password) {
    log('==> setPassword called with: $password');
    final result = validateField('password', password);
    log('==> password: $password');
    if (!result.isValid && result.error != null) {
      state = state.copyWith(password: password.trim(), isPasswordInvalid: true, validationErrors: {
        'password': result.error!,
      });
    } else {
      state = state.copyWith(password: password.trim(), isPasswordInvalid: false);
    }
  }

  void setConfirmPassword(String password) {
   final pipe = _getConfirmPasswordValidationPipe();
    final result = pipe.validate(password);
    log('==> confirmPassword: $password');
    if (!result.isValid && result.error != null) {
      state = state.copyWith(
        confirmPassword: password.trim(), 
        isConfirmPasswordInvalid: true, 
        validationErrors: {
          'confirmPassword': result.error!,
        }
      );
    } else {
      state = state.copyWith(
        confirmPassword: password.trim(), 
        isConfirmPasswordInvalid: false
      );
    }
  }

  void setName(String name) {
    log('==> setName called with: $name');
    print('==> setName called with: $name');
     final result = validateField('name', name);
     log('==> name: $name');
       if (!result.isValid && result.error != null) {
      state = state.copyWith(name: name.trim(), isNameInvalid: true, validationErrors: {
        'name': result.error!,
      });
    } else {
      state = state.copyWith(name: name.trim(), isNameInvalid: false);
    }
  }

  void setEmail(String value) {
    final result = validateField('email', value);
    log('==> email: $value');
    if (!result.isValid && result.error != null) {
      state = state.copyWith(email: value.trim(), isEmailInvalid: true, validationErrors: {
        'email': result.error!,
      });
    } else {
      state = state.copyWith(email: value.trim(), isEmailInvalid: false);
    }
  }

  void setUserName(String name) {
    final result = validateField('userName', name);
    log('==> userName: $name');
    if (!result.isValid && result.error != null) {
      state = state.copyWith(userName: name.trim(), isUserNameInvalid: true, validationErrors: {
        'userName': result.error!,
      });
    } else {
      state = state.copyWith(userName: name.trim(), isUserNameInvalid: false);
    }
  }

  void toggleShowPassword() {
    log('==> showPassword: ${!state.showPassword}');
    state = state.copyWith(showPassword: !state.showPassword);
  }

  void toggleShowConfirmPassword() {
    log('==> showConfirmPassword: ${!state.showConfirmPassword}');
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
          // clear text fields
          emailController.clear();
          passwordController.clear();
          confirmPasswordController.clear();
          nameController.clear();
          userNameController.clear();
          context.pushNamed(RouteName.login);
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

  bool get isFormValid {
    // Check if all required fields are not empty
    if (state.email.isEmpty || 
        state.password.isEmpty || 
        state.confirmPassword.isEmpty || 
        state.name.isEmpty || 
        state.userName.isEmpty) {
      return false;
    }

    // Check if any field has validation errors
    if (state.isEmailInvalid || 
        state.isPasswordInvalid || 
        state.isConfirmPasswordInvalid || 
        state.isNameInvalid || 
        state.isUserNameInvalid) {
      return false;
    }

    return true;
  }

  @override
  void dispose() {
    nameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
