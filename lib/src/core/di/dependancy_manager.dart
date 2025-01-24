import 'package:get_it/get_it.dart';

import 'package:wise/src/core/handlers/http_service.dart';
import 'package:wise/src/repository/auth_repository.dart';
import 'package:wise/src/repository/exchange_rate_repository.dart';
import 'package:wise/src/repository/impl/auth_repository_impl.dart';
import 'package:wise/src/repository/impl/exchange_rate_repository_impl.dart';
import 'package:wise/src/repository/impl/transaction_repository_impl.dart';
import 'package:wise/src/repository/transaction_repository.dart';

final GetIt getIt = GetIt.instance;

void setUpDependencies() {
  getIt.registerLazySingleton<HttpService>(() => HttpService());
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  getIt.registerLazySingleton<ExchangeRateRepository>(() => ExchangeRateRepositoryImpl());
  getIt.registerLazySingleton<TransactionRepository>(() => TransactionRepositoryImpl());
}

final httpService = getIt.get<HttpService>();
final authRepository = getIt.get<AuthRepository>();
final exchangeRateRepository = getIt.get<ExchangeRateRepository>();
final transactionRepository = getIt.get<TransactionRepository>();
