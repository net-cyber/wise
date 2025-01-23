import 'package:flutter/material.dart';
import 'package:wise/src/presentation/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final BuildContext context;

  const CustomButton({
    required this.onPressed,
    required this.text,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          text,
          style:  TextStyle(
            fontSize: 18,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }
}