import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wise/src/core/di/dependancy_manager.dart';
import 'package:wise/src/presentation/pages/auth/register/riverpod/notifier/register_notifier.dart';
import 'package:wise/src/presentation/pages/auth/register/riverpod/state/register_state.dart';

final registerProvider = StateNotifierProvider<RegisterNotifier, RegisterState>((ref) {
  return RegisterNotifier(authRepository);
});
