import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wise/src/core/constants/app_constants.dart';
import 'package:wise/src/core/di/injection.dart';
import 'package:wise/src/core/handlers/handlers.dart';
import 'package:wise/src/model/currency_conversion_response.dart';
import 'package:wise/src/model/exchage_rate_response.dart';
import 'package:wise/src/presentation/pages/main/convert_currency/riverpod/params/convert_currency_request_params.dart';
import 'package:wise/src/repository/exchange_rate_repository.dart';

class ExchangeRateRepositoryImpl extends ExchangeRateRepository {
  @override
  Future<ApiResult<List<ExchangeRateResponse>>> getExchangeRate() async {
       try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '${AppConstants.baseUrl}/rates',
      );
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        final exchangeRates = data.map((item) => ExchangeRateResponse.fromJson(item)).toList();
        return ApiResult.success(
          data: exchangeRates,
        );
      } else {
        return ApiResult.failure(error: NetworkExceptions.getDioException(response.statusCode));
      }
    } catch (e) {
      debugPrint('==> get exchange rate failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
    
  }

  @override
  Future<ApiResult<CurrencyConversionResponse>> convertCurrency(ConvertCurrencyRequestParams request) async {
    try {
      final data = {
        'from_currency': request.fromCurrency,
        'to_currency': request.toCurrency,
        'amount': double.parse(request.amount.trim()),
      };
      log('convert currency in ${data}');
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post('${AppConstants.baseUrl}/convert', data: data);
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final currencyConversionResponse = CurrencyConversionResponse.fromJson(data);
        return ApiResult.success(data: currencyConversionResponse);
      } else {
        return ApiResult.failure(error: NetworkExceptions.getDioException(response.statusCode));
      }
    } catch (e) {
      debugPrint('==> convert currency failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
