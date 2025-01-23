import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wise/src/core/di/dependancy_manager.dart';
import 'package:wise/src/presentation/pages/auth/login/riverpod/notifier/login_notifier.dart';
import 'package:wise/src/presentation/pages/auth/login/riverpod/state/login_state.dart';
import 'package:wise/src/repository/auth_repository.dart';

final loginProvider = StateNotifierProvider.autoDispose<LoginNotifier, LoginState>((ref) {
  return LoginNotifier(getIt.get<AuthRepository>());
});