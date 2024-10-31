import 'package:flutter/material.dart';

class OnboardingImage extends StatelessWidget {
  final String imagePath;

  const OnboardingImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Image.asset(imagePath, height: 300),
    );
  }
}