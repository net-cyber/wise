import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wise/src/core/utils/utils.dart';

import '../state/app_state.dart';

class AppNotifier extends StateNotifier<AppState> {
  AppNotifier() : super(const AppState()) {
    getThemeMode();
  }

  Future<void> getThemeMode() async {
    final isDarkMode = LocalStorage.instance.getAppThemeMode();
    state = state.copyWith(isDarkMode: isDarkMode);
  }

  Future<void> changeTheme(bool? isDarkMode) async {
    await LocalStorage.instance.setAppThemeMode(isDarkMode ?? false);
    state = state.copyWith(isDarkMode: isDarkMode ?? false);
  }


}
