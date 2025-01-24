import 'package:flutter/material.dart';
import 'package:wise/src/model/exchage_rate_response.dart';
import 'package:wise/src/model/user_model.dart';

class SendMoneyState {
  final bool isLoadingUserDetails;
  final String error;
  final UserModel? user;
  final String amount;
  final bool isAmountInvalid;
  final Map<String, String>? validationErrors;
  SendMoneyState({
    this.isLoadingUserDetails = false,
    this.error = '',
    this.user,
    this.amount = '',
    this.isAmountInvalid = false,
    this.validationErrors,
  });

  SendMoneyState copyWith({
    bool? isLoadingUserDetails,
    String? error,
    UserModel? user,
    String? amount,
    bool? isAmountInvalid,
    Map<String, String>? validationErrors,
  }) {
    return SendMoneyState(
      isLoadingUserDetails: isLoadingUserDetails ?? this.isLoadingUserDetails,
      error: error ?? this.error,
      user: user ?? this.user,
      amount: amount ?? this.amount,
      isAmountInvalid: isAmountInvalid ?? this.isAmountInvalid,
      validationErrors: validationErrors ?? this.validationErrors,
    );
  }
}
