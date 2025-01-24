import 'package:wise/src/core/handlers/handlers.dart';
import 'package:wise/src/model/currency_conversion_response.dart';
import 'package:wise/src/model/exchage_rate_response.dart';
import 'package:wise/src/presentation/pages/main/convert_currency/riverpod/params/convert_currency_request_params.dart';

abstract class ExchangeRateRepository {
  Future<ApiResult<List<ExchangeRateResponse>>> getExchangeRate();
  Future<ApiResult<CurrencyConversionResponse>> convertCurrency(ConvertCurrencyRequestParams request);
}


