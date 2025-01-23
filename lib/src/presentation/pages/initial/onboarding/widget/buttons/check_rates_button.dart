import 'package:flutter/material.dart';
import 'package:wise/src/presentation/theme/app_colors.dart';
class CheckRatesButton extends StatelessWidget {
  final VoidCallback onPressed;
  final BuildContext context;

  const CheckRatesButton({required this.onPressed, required this.context});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child:  Text(
        'Check our rates',
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 16,
        ),
      ),
    );
  }
}
