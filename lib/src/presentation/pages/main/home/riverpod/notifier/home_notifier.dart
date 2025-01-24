import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wise/src/core/handlers/network_exceptions.dart';
import 'package:wise/src/presentation/pages/main/home/riverpod/state/home_state.dart';
import 'package:wise/src/repository/exchange_rate_repository.dart';


class HomeNotifier extends StateNotifier<HomeState> {
  final ExchangeRateRepository _exchangeRateRepository;
  HomeNotifier(this._exchangeRateRepository) : super(HomeState()) {
    getExchangeRate();
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

 
}