import 'package:flutter/material.dart';
import 'package:wise/src/presentation/theme/app_colors.dart';

class OnboardingProgressIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalItems;

  const OnboardingProgressIndicator({
    required this.currentIndex,
    required this.totalItems,
  });

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: (currentIndex + 1) / totalItems,
      backgroundColor: Colors.grey[200],
      valueColor: const AlwaysStoppedAnimation<Color>(
        AppColors.onboardingBackgroundDark,
      ),
    );
  }
}
