import 'package:flutter_riverpod/flutter_riverpod.dart';

class DragSplashNotifier extends StateNotifier<double> {
  DragSplashNotifier() : super(0);

  void updateDragPosition(double delta) {
    if (delta < 0) {
      state = (state + delta).clamp(-240, 0);
    }
  }

  void resetPosition() {
    state = 0;
  }

  bool get shouldNavigate => state <= -200;
}


