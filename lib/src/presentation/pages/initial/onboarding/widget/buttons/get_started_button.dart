import 'package:flutter/material.dart';
import 'package:wise/src/presentation/theme/app_colors.dart';
import 'custom_button.dart';

class GetStartedButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GetStartedButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: onPressed,
      text: 'Get started',
      backgroundColor: AppColors.splashBackground,
    );
  }
}

