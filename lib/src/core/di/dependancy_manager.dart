import 'package:get_it/get_it.dart';

import 'package:wise/src/core/handlers/http_service.dart';
import 'package:wise/src/repository/auth_repository.dart';
import 'package:wise/src/repository/impl/auth_repository_impl.dart';

final GetIt getIt = GetIt.instance;

void setUpDependencies() {
  getIt.registerLazySingleton<HttpService>(() => HttpService());
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
}

final httpService = getIt.get<HttpService>();
final authRepository = getIt.get<AuthRepository>();
