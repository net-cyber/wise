import 'package:flutter_test/flutter_test.dart';
import 'package:wise/src/presentation/pages/initial/drag_onboarding/riverpod_drag/drag_splash_notifier.dart';

void main() {
  late DragSplashNotifier notifier;

  setUp(() {
    notifier = DragSplashNotifier();
  });

  group('DragSplashNotifier', () {
    test('initial state should be 0', () {
      final initialState = notifier.state;
      expect(initialState, 0);
    });

    group('updateDragPosition', () {
      test('should update state when delta is negative', () {
        // arrange
        const expectedPosition = -100.0;
        // act
        notifier.updateDragPosition(-100);
        // assert
        expect(notifier.state, expectedPosition);
      });

      test('should not exceed minimum boundary', () {
        const minimumBoundary = -240.0;
        notifier.updateDragPosition(-300);
        expect(notifier.state, minimumBoundary);
      });

      test('should handle incremental changes', () {
        const increment = -10.0;
        const expectedFinalPosition = -30.0;
        notifier.updateDragPosition(increment);
        notifier.updateDragPosition(increment);
        notifier.updateDragPosition(increment);
        expect(notifier.state, expectedFinalPosition);
      });
    });

    group('resetPosition', () {
      test('should reset state to 0 from any position', () {
        notifier.updateDragPosition(-150);
        expect(notifier.state, -150, reason: 'Verify setup position');
        notifier.resetPosition();
        expect(notifier.state, 0);
      });
    });

    group('shouldNavigate', () {
      test('should return true when passing navigation threshold', () {
        const navigationThreshold = -200.0;
        notifier.updateDragPosition(navigationThreshold);
        final shouldNavigate = notifier.shouldNavigate;
        expect(shouldNavigate, true);
      });

      test('should return false when above navigation threshold', () {
        const aboveThreshold = -199.0;
        notifier.updateDragPosition(aboveThreshold);
        final shouldNavigate = notifier.shouldNavigate;
        expect(shouldNavigate, false);
      });
    });

    group('Integration', () {
      test('should handle complete drag sequence correctly', () {
        const firstDrag = -50.0;
        const secondDrag = -100.0;
        const thirdDrag = -100.0;
        notifier.updateDragPosition(firstDrag);
        final firstState = notifier.state;
        final firstNavigate = notifier.shouldNavigate;
        expect(firstState, firstDrag);
        expect(firstNavigate, false);
        notifier.updateDragPosition(secondDrag);
        final secondState = notifier.state;
        final secondNavigate = notifier.shouldNavigate;
        expect(secondState, firstDrag + secondDrag);
        expect(secondNavigate, false);
        notifier.updateDragPosition(thirdDrag);
        final thirdState = notifier.state;
        final thirdNavigate = notifier.shouldNavigate;
        expect(thirdState, -240.0);
        expect(thirdNavigate, true);
      });
    });
  });
}