import 'package:wise/src/model/currency_conversion_response.dart';
import 'package:wise/src/model/exchage_rate_response.dart';

class ConvertCurrencyState {
  final bool isLoadingCurrency;
  final bool isConvertingCurrency;
  final String amount;
  final String fromCurrency;
  final String toCurrency;
  final CurrencyConversionResponse? currencyConversion;
  final List<ExchangeRateResponse> exchangeRates;
  final String error;

  ConvertCurrencyState({
    this.isLoadingCurrency = true,
    this.isConvertingCurrency = false,
    this.amount = '',
    this.fromCurrency = '',
    this.toCurrency = '',
    this.currencyConversion,
    this.exchangeRates = const [],
    this.error = '',
  });

  ConvertCurrencyState copyWith({
    bool? isLoadingCurrency,
    bool? isConvertingCurrency,
    String? amount,
    String? fromCurrency,
    String? toCurrency,
    CurrencyConversionResponse? currencyConversion,
    List<ExchangeRateResponse>? exchangeRates,
    String? error,
  }) {
    return ConvertCurrencyState(
      isLoadingCurrency: isLoadingCurrency ?? this.isLoadingCurrency,
      isConvertingCurrency: isConvertingCurrency ?? this.isConvertingCurrency,
      amount: amount ?? this.amount,
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
      currencyConversion: currencyConversion ?? this.currencyConversion,
      exchangeRates: exchangeRates ?? this.exchangeRates,
      error: error ?? this.error,
    );
  }
}
