import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wise/src/core/handlers/network_exceptions.dart';
import 'package:wise/src/presentation/pages/main/home/riverpod/state/home_state.dart';
import 'package:wise/src/presentation/pages/main/send_money/riverpod/state/send_money_state.dart';
import 'package:wise/src/repository/auth_repository.dart';
import 'package:wise/src/repository/exchange_rate_repository.dart';


class SendMoneyNotifier extends StateNotifier<SendMoneyState> {
  final AuthRepository _authRepository;
  SendMoneyNotifier(this._authRepository) : super(SendMoneyState()) {
    getUserDetails();
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

 
}