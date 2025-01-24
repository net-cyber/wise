import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wise/src/core/di/dependancy_manager.dart';
import 'package:wise/src/presentation/pages/main/send_money/riverpod/notifier/send_money_notifier.dart';
import 'package:wise/src/presentation/pages/main/send_money/riverpod/state/send_money_state.dart';
import 'package:wise/src/repository/auth_repository.dart';
import 'package:wise/src/repository/transaction_repository.dart';


final sendMoneyNotifierProvider = StateNotifierProvider.autoDispose<SendMoneyNotifier, SendMoneyState>((ref) {
  return SendMoneyNotifier(authRepository: getIt<AuthRepository>(), transactionRepository: getIt<TransactionRepository>());
});
