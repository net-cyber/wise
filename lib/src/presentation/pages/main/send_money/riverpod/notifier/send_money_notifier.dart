import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wise/src/core/handlers/app_connectivity.dart';
import 'package:wise/src/core/handlers/network_exceptions.dart';
import 'package:wise/src/core/navigation/navigation_service.dart';
import 'package:wise/src/core/utils/app_helpers.dart';
import 'package:wise/src/core/validators/string_validators.dart';
import 'package:wise/src/core/validators/validation_mixin.dart';
import 'package:wise/src/core/validators/validation_pipe.dart';
import 'package:wise/src/presentation/pages/main/send_money/riverpod/params/send_money_request_params.dart';
import 'package:wise/src/presentation/pages/main/send_money/riverpod/provider/send_money_provider.dart';
import 'package:wise/src/presentation/pages/main/send_money/riverpod/state/send_money_state.dart';
import 'package:wise/src/repository/auth_repository.dart';
import 'package:wise/src/repository/transaction_repository.dart';


class SendMoneyNotifier extends StateNotifier<SendMoneyState> with ValidationMixin {
  final AuthRepository authRepository;
  final TransactionRepository transactionRepository;

  final TextEditingController amountController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  SendMoneyNotifier({required this.authRepository, required this.transactionRepository}) : super(SendMoneyState()) {
    getUserDetails(NavigationService.currentContext!);
    addValidationPipe('email', ValidationPipe([
      RequiredValidator(),
      EmailValidator(),

    ]));
       addValidationPipe('amount', ValidationPipe([
    ]));
  
  }

  ValidationPipe<String> _getAmountValidationPipe() {
    return ValidationPipe([
      RequiredValidator(),
      MustBeNumberValidator(),
      MinValueValidator(1),
      MaxValueValidator(state.user?.balance ?? 0),
    ]);
  }
   void setEmail(String value) {
    final result = validateField('email', value);
    log('==> email: $value');
    if (!result.isValid && result.error != null) {
      state = state.copyWith(email: value.trim(), isEmailNotValid: true, validationErrors: {
        'email': result.error!,
      });
    } else {
      state = state.copyWith(email: value.trim(), isEmailNotValid: false,);
    }
  }
  
  void setAmount(String amount) {
    final pipe = _getAmountValidationPipe();
    final result = pipe.validate(amount);
    if (!result.isValid && result.error != null) {
      state = state.copyWith(
        amount: amount.trim(), 
        isAmountInvalid: true, 
        validationErrors: {
          'amount': result.error!,
        }
      );
    } else {
      state = state.copyWith(
        amount: amount.trim(), 
        isAmountInvalid: false
      );
    }
  }

  bool get isFormValid {
    return state.amount.isNotEmpty && !state.isAmountInvalid && state.email.isNotEmpty && !state.isEmailNotValid;
  }

  Future<void> getUserDetails(BuildContext context) async {
    state = state.copyWith(isLoadingUserDetails: true);
    
    final result = await authRepository.getUserDetails(context);
    result.when(
      success: (data) => state = state.copyWith(user: data),
      failure: (error) {
        final errorMessage = NetworkExceptions.getErrorMessage(error);
        return state = state.copyWith(error: errorMessage);
      },
    );
    state = state.copyWith(isLoadingUserDetails: false);
  }

  void sendMoney(BuildContext context, WidgetRef ref) async {
    if (!isFormValid) {
      return;
    }
    // if there is no internet connection, show a snackbar
    final connected = await AppConnectivity.connectivity();
    if (!connected) {
      AppHelpers.showNoConnectionSnackBar(context);
      return;
    }
    state = state.copyWith(isTransactionLoading: true);
    final result = await transactionRepository.sendMoney(SendMoneyRequestParams(amount: state.amount, email: state.email));
    result.when(
      success: (data) {
        state = state.copyWith(transactionResponse: data);

        emailController.clear();
        amountController.clear();
        // invalidate the provider
        getUserDetails(context);
        ref.invalidate(sendMoneyNotifierProvider);
        state = state.copyWith(isTransactionLoading: false);

        AppHelpers.showCheckFlash(context, 'Transfer successful');
        
        
      },
      failure: (error) {
        final errorMessage = NetworkExceptions.getErrorMessage(error);
        AppHelpers.showErrorFlash(context, errorMessage);
         ref.invalidate(sendMoneyNotifierProvider);
        return state = state.copyWith(error: errorMessage);

        
      },
    );
  }
  @override
  void dispose() {
    amountController.dispose();
    emailController.dispose();
    super.dispose();
  }
}