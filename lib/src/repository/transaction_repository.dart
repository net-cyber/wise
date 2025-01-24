import 'package:dartz/dartz.dart';
import 'package:wise/src/core/handlers/handlers.dart';
import 'package:wise/src/model/transaction_history_response.dart';
import 'package:wise/src/model/transaction_response.dart';
import 'package:wise/src/presentation/pages/main/convert_currency/riverpod/params/convert_currency_request_params.dart';
import 'package:wise/src/presentation/pages/main/send_money/riverpod/params/send_money_request_params.dart';

abstract class TransactionRepository {
  Future<ApiResult<TransactionResponse>> sendMoney(SendMoneyRequestParams request);
  Future<ApiResult<TransactionHistoryResponse>> getTransactionHistory();
}

