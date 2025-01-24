import 'package:flutter/material.dart';
import 'package:wise/src/core/constants/app_constants.dart';
import 'package:wise/src/core/di/injection.dart';
import 'package:wise/src/core/handlers/handlers.dart';
import 'package:wise/src/model/transaction_history_response.dart';
import 'package:wise/src/model/transaction_response.dart';
import 'package:wise/src/presentation/pages/main/convert_currency/riverpod/params/convert_currency_request_params.dart';
import 'package:wise/src/presentation/pages/main/send_money/riverpod/params/send_money_request_params.dart';
import 'package:wise/src/repository/transaction_repository.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  @override
  Future<ApiResult<TransactionResponse>> sendMoney(SendMoneyRequestParams request) async {
     try {
      final data = {
        'amount': double.parse(request.amount.trim()),
        'to_user_email': request.email,
      };
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post('${AppConstants.baseUrl}/transfer', data: data);
      final transactionResponse = TransactionResponse.fromJson(response.data);
      return ApiResult.success(data: transactionResponse);
    } catch (e) {
      debugPrint('==> send money failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<TransactionHistoryResponse>> getTransactionHistory() async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get('${AppConstants.baseUrl}/transactions');
      final transactionHistoryResponse = TransactionHistoryResponse.fromJson(response.data);
      return ApiResult.success(data: transactionHistoryResponse);
    } catch (e) {
      debugPrint('==> get transaction history failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }


}
