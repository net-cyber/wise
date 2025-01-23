import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class OnboardingImage extends StatelessWidget {
  final String imagePath;

  const OnboardingImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
    
      width: double.infinity,
      height: 300.h,
      child: Image.asset(imagePath, height: 300.h),
    );
  }
}