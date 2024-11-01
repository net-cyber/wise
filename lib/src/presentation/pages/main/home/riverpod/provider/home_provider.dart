import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wise/src/presentation/pages/main/home/riverpod/notifier/home_notifier.dart';
import 'package:wise/src/presentation/pages/main/home/riverpod/state/home_state.dart';


final homeNotifierProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});
