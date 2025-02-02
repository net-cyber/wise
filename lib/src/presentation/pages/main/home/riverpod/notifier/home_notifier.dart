import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wise/src/core/handlers/network_exceptions.dart';
import 'package:wise/src/presentation/pages/main/home/riverpod/state/home_state.dart';
import 'package:wise/src/repository/exchange_rate_repository.dart';
import 'package:wise/src/repository/transaction_repository.dart';


class HomeNotifier extends StateNotifier<HomeState> {
  final ExchangeRateRepository _exchangeRateRepository;
  final TransactionRepository _transactionRepository;
  HomeNotifier(this._exchangeRateRepository, this._transactionRepository) : super(HomeState()) {
    getExchangeRate();
    getTransactionHistory();
  }

  Future<void> getExchangeRate() async {
    state = state.copyWith(isLoading: true);
    
    final result = await _exchangeRateRepository.getExchangeRate();
    result.when(
      success: (data) => state = state.copyWith(exchangeRates: data),
      failure: (error) {
        final errorMessage = NetworkExceptions.getErrorMessage(error);
        return state = state.copyWith(error: errorMessage);
      },
    );
    state = state.copyWith(isLoading: false);
  }

  Future<void> getTransactionHistory() async {
    state = state.copyWith(isLoading: true);
    final result = await _transactionRepository.getTransactionHistory();
    result.when(
      success: (data) => state = state.copyWith(transactionHistory: data),
      failure: (error) {
        final errorMessage = NetworkExceptions.getErrorMessage(error);
        return state = state.copyWith(error: errorMessage);
      },
    );
    state = state.copyWith(isLoading: false);
  }

  Future<void> refreshData() async {
    await Future.wait([
      getExchangeRate(),
      getTransactionHistory(),
    ]);
  }
}
