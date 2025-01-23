import 'package:flutter/material.dart';
import 'package:wise/src/presentation/theme/app_colors.dart';
import 'custom_button.dart';

class GetStartedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final BuildContext context;

  const GetStartedButton({required this.onPressed, required this.context});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      context: context,
      onPressed: onPressed,
      text: 'Get started',
    );
  }
}

