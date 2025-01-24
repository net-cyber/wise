
import 'package:wise/src/model/transaction_response.dart';
import 'package:wise/src/model/user_model.dart';

class SendMoneyState {
  final bool isLoadingUserDetails;
  final String error;
  final UserModel? user;
  final String amount;
  final bool isAmountInvalid;
  final Map<String, String> validationErrors;
  final String email;
  final bool isEmailNotValid;
  final TransactionResponse? transactionResponse;
  final bool isTransactionLoading;
  SendMoneyState({
    this.isLoadingUserDetails = false,
    this.error = '',
    this.user,
    this.amount = '',
    this.isAmountInvalid = false,
    this.validationErrors = const {},
    this.email = '',
    this.isEmailNotValid = false,
    this.transactionResponse,
    this.isTransactionLoading = false,
  });

  SendMoneyState copyWith({
    bool? isLoadingUserDetails,
    String? error,
    UserModel? user,
    String? amount,
    bool? isAmountInvalid,
    Map<String, String>? validationErrors,
    String? email,
    bool? isEmailNotValid,
    TransactionResponse? transactionResponse,
    bool? isTransactionLoading,
  }) {
    return SendMoneyState(
      isLoadingUserDetails: isLoadingUserDetails ?? this.isLoadingUserDetails,
      error: error ?? this.error,
      user: user ?? this.user,
      amount: amount ?? this.amount,
      isAmountInvalid: isAmountInvalid ?? this.isAmountInvalid,
      validationErrors: validationErrors ?? this.validationErrors,
      email: email ?? this.email,
      isEmailNotValid: isEmailNotValid ?? this.isEmailNotValid,
      transactionResponse: transactionResponse ?? this.transactionResponse,
      isTransactionLoading: isTransactionLoading ?? this.isTransactionLoading,
    );
  }
}
