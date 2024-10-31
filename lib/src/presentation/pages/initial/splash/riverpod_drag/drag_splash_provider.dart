import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'drag_splash_notifier.dart';

final dragSplashProvider = StateNotifierProvider<DragSplashNotifier, double>((ref) {
  return DragSplashNotifier();
});