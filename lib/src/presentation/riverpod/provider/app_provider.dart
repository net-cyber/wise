import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifier/app_notifier.dart';
import '../state/app_state.dart';

final appProvider = StateNotifierProvider<AppNotifier, AppState>(
  (ref) => AppNotifier(),
);
