import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wise/src/presentation/pages/initial/splash/riverpod/notifier/splash_notifier.dart';
import 'package:wise/src/presentation/pages/initial/splash/riverpod/state/splash_state.dart';

final splashProvider = StateNotifierProvider<SplashNotifier, SplashState>(
  (ref) => SplashNotifier(),
);
