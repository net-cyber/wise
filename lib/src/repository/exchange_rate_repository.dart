import 'package:wise/src/core/handlers/handlers.dart';
import 'package:wise/src/model/exchage_rate_response.dart';

abstract class ExchangeRateRepository {
  Future<ApiResult<List<ExchangeRateResponse>>> getExchangeRate();
}


