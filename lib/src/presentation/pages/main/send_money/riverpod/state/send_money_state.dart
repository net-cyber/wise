import 'package:flutter/material.dart';
import 'package:wise/src/model/exchage_rate_response.dart';
import 'package:wise/src/model/user_model.dart';

class SendMoneyState {
  final bool isLoadingUserDetails;
  final String error;
  final UserModel? user;
  SendMoneyState({
    this.isLoadingUserDetails = false,
    this.error = '',
    this.user,
  });

  SendMoneyState copyWith({
    bool? isLoadingUserDetails,
    String? error,
    UserModel? user,
  }) {
    return SendMoneyState(
      isLoadingUserDetails: isLoadingUserDetails ?? this.isLoadingUserDetails,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }
}
