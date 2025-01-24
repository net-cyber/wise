import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wise/src/core/handlers/network_exceptions.dart';
import 'package:wise/src/core/validators/string_validators.dart';
import 'package:wise/src/core/validators/validation_mixin.dart';
import 'package:wise/src/core/validators/validation_pipe.dart';
import 'package:wise/src/model/exchage_rate_response.dart';
import 'package:wise/src/presentation/pages/main/convert_currency/riverpod/params/convert_currency_request_params.dart';
import 'package:wise/src/presentation/pages/main/convert_currency/riverpod/state/convert_currency_state.dart';
import 'package:wise/src/repository/exchange_rate_repository.dart';


class ConvertCurrencyNotifier extends StateNotifier<ConvertCurrencyState> with ValidationMixin {
  final ExchangeRateRepository _exchangeRateRepository;
  final TextEditingController amountController = TextEditingController();
  ConvertCurrencyNotifier(this._exchangeRateRepository,) : super(ConvertCurrencyState()) {
    getExchangeRate().then((_) {
      if (state.exchangeRates.isNotEmpty) {
        // Set default values for fromCurrency and toCurrency
        state = state.copyWith(
          fromCurrency: state.exchangeRates[0].currencyCode,
          toCurrency: state.exchangeRates.length > 1 ? state.exchangeRates[1].currencyCode : state.exchangeRates[0].currencyCode,
        );
      }
    });
    addValidationPipe('amount', ValidationPipe([
      RequiredValidator(),
      NumberValidator(),
    ]));
  }

  bool get isFormValid {
    return state.amount.isNotEmpty ;
  }

  void setAmount(String value) {
    final result = validateField('amount', value);
    log('==> amount: $value');
    if (!result.isValid && result.error != null) {
      state = state.copyWith(amount: value.trim(), error: result.error!);
    } else {
      state = state.copyWith(amount: value.trim(), error: '');
    }
  }

  Future<void> getExchangeRate() async {
    state = state.copyWith(isLoadingCurrency: true);
    
    final result = await _exchangeRateRepository.getExchangeRate();
    result.when(
      success: (data) => state = state.copyWith(exchangeRates: data),
      failure: (error) {
        final errorMessage = NetworkExceptions.getErrorMessage(error);
        return state = state.copyWith(error: errorMessage);
      },
    );
    state = state.copyWith(isLoadingCurrency: false);
  }

  Future<void> convertCurrency({required String fromCurrency, required String toCurrency}) async {
    state = state.copyWith(isConvertingCurrency: true);
    final request = ConvertCurrencyRequestParams(
      fromCurrency: fromCurrency,
      toCurrency: toCurrency,
      amount: amountController.text.trim(),
    );
    final result = await _exchangeRateRepository.convertCurrency(request);
    result.when(
      success: (data) {
        state = state.copyWith(currencyConversion: data, isConvertingCurrency: false);
        log('==> currencyConversion: ${data.convertedAmount}');
      },
      failure: (error) {
        final errorMessage = NetworkExceptions.getErrorMessage(error);
        return state = state.copyWith(error: errorMessage, isConvertingCurrency: false);
      },
    );
    state = state.copyWith(isConvertingCurrency: false);
  }

  void updateSelectedCurrency(ExchangeRateResponse currency, bool isFromCurrency) {
    if (isFromCurrency) {
      state = state.copyWith(fromCurrency: currency.currencyCode);
    } else {
      state = state.copyWith(toCurrency: currency.currencyCode);
    }
  }

}
