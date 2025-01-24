import 'package:flutter/material.dart';
import 'package:wise/src/model/exchage_rate_response.dart';

class SendMoneyState {
  final bool isLoading;
  final String error;

  SendMoneyState({
    this.isLoading = true,
    this.error = '',
  });

  SendMoneyState copyWith({
    bool? isLoading,
    String? error,
  }) {
    return SendMoneyState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
