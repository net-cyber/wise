import 'package:flutter/material.dart';
import 'package:wise/src/presentation/theme/app_colors.dart';
class CheckRatesButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CheckRatesButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: const Text(
        'Check our rates',
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: AppColors.black,
          fontSize: 16,
        ),
      ),
    );
  }
}
