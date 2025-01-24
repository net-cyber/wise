import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wise/src/core/di/dependancy_manager.dart';
import 'package:wise/src/presentation/pages/main/convert_currency/riverpod/notifier/convert_currency_notifier.dart';
import 'package:wise/src/presentation/pages/main/convert_currency/riverpod/state/convert_currency_state.dart';
import 'package:wise/src/repository/exchange_rate_repository.dart';

final convertCurrencyProvider = StateNotifierProvider<ConvertCurrencyNotifier, ConvertCurrencyState>((ref) => ConvertCurrencyNotifier(
  getIt.get<ExchangeRateRepository>(),
),
);
