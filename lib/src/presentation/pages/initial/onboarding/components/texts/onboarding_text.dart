import 'package:flutter/material.dart';

class OnboardingText extends StatelessWidget {
  final String text;

  const OnboardingText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        height: 1.2,
      ),
      textAlign: TextAlign.center,
    );
  }
}
