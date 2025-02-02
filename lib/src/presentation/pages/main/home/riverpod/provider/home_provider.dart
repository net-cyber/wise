import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wise/src/core/di/dependancy_manager.dart';
import 'package:wise/src/presentation/pages/main/home/riverpod/notifier/home_notifier.dart';
import 'package:wise/src/presentation/pages/main/home/riverpod/state/home_state.dart';
import 'package:wise/src/repository/exchange_rate_repository.dart';
import 'package:wise/src/repository/transaction_repository.dart';


final homeNotifierProvider = StateNotifierProvider.autoDispose<HomeNotifier, HomeState>((ref) {
  return HomeNotifier(getIt<ExchangeRateRepository>(), getIt<TransactionRepository>());
});