import 'package:flutter/material.dart';
import 'package:wise/src/model/exchage_rate_response.dart';
import 'package:wise/src/model/transaction_history_response.dart';

class HomeState {
  final bool isLoading;
  final String initials;
  final String earnAmount;
  final List<BalanceCardData> balances;
  final List<TransactionData> transactions;
  final List<ExchangeRateResponse> exchangeRates;
  final TransactionHistoryResponse? transactionHistory;
  final String error;

  HomeState({
    this.isLoading = true,
    this.initials = '',
    this.earnAmount = '',
    this.balances = const [],
    this.transactions = const [],
    this.exchangeRates = const [],
    this.transactionHistory,
    this.error = '',
  });

  HomeState copyWith({
    bool? isLoading,
    String? initials,
    String? earnAmount,
    List<BalanceCardData>? balances,
    List<TransactionData>? transactions,
    List<ExchangeRateResponse>? exchangeRates,
    TransactionHistoryResponse? transactionHistory,
    String? error,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      initials: initials ?? this.initials,
      earnAmount: earnAmount ?? this.earnAmount,
      balances: balances ?? this.balances,
      transactions: transactions ?? this.transactions,
      exchangeRates: exchangeRates ?? this.exchangeRates,
      transactionHistory: transactionHistory ?? this.transactionHistory,
      error: error ?? this.error,
    );
  }
}

class BalanceCardData {
  final String flag;
  final String amount;
  final String currency;

  BalanceCardData({
    required this.flag,
    required this.amount,
    required this.currency,
  });
}

class TransactionData {
  final IconData icon;
  final String title;
  final String subtitle;
  final String amount;

  TransactionData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
  });
}