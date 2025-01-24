import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wise/src/core/handlers/app_connectivity.dart';
import 'package:wise/src/core/handlers/network_exceptions.dart';
import 'package:wise/src/core/utils/app_helpers.dart';
import 'package:wise/src/core/validators/string_validators.dart';
import 'package:wise/src/core/validators/validation_mixin.dart';
import 'package:wise/src/core/validators/validation_pipe.dart';
import 'package:wise/src/presentation/pages/main/send_money/riverpod/state/send_money_state.dart';
import 'package:wise/src/repository/auth_repository.dart';


class SendMoneyNotifier extends StateNotifier<SendMoneyState> with ValidationMixin {
  final AuthRepository _authRepository;

  final TextEditingController amountController = TextEditingController();

  SendMoneyNotifier(this._authRepository) : super(SendMoneyState()) {
    getUserDetails();
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
    return state.amount.isNotEmpty && !state.isAmountInvalid;
  }

  Future<void> getUserDetails() async {
    state = state.copyWith(isLoadingUserDetails: true);
    
    final result = await _authRepository.getUserDetails();
    result.when(
      success: (data) => state = state.copyWith(user: data),
      failure: (error) {
        final errorMessage = NetworkExceptions.getErrorMessage(error);
        return state = state.copyWith(error: errorMessage);
      },
    );
    state = state.copyWith(isLoadingUserDetails: false);
  }

  // void sendMoney(BuildContext context) async {
  //   if (!isFormValid) {
  //     return;
  //   }
  //   // if there is no internet connection, show a snackbar
  //   final connected = await AppConnectivity.connectivity();
  //   if (!connected) {
  //     AppHelpers.showNoConnectionSnackBar(context);
  //     return;
  //   }
  //   final result = await _authRepository.sendMoney(state.amount);
  //   result.when(
  //     success: (data) => state = state.copyWith(user: data),
  //     failure: (error) {
  //       final errorMessage = NetworkExceptions.getErrorMessage(error);
  //       return state = state.copyWith(error: errorMessage);
  //     },
  //   );
  // }
 
 
}
