import 'package:flutter/material.dart';

class HomeState {
  final bool isLoading;
  final String initials;
  final String earnAmount;
  final List<BalanceCardData> balances;
  final List<TransactionData> transactions;

  HomeState({
    this.isLoading = true,
    this.initials = '',
    this.earnAmount = '',
    this.balances = const [],
    this.transactions = const [],
  });

  HomeState copyWith({
    bool? isLoading,
    String? initials,
    String? earnAmount,
    List<BalanceCardData>? balances,
    List<TransactionData>? transactions,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      initials: initials ?? this.initials,
      earnAmount: earnAmount ?? this.earnAmount,
      balances: balances ?? this.balances,
      transactions: transactions ?? this.transactions,
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