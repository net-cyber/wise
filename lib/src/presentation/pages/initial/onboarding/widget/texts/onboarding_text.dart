import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingText extends StatelessWidget {
  final String text;

  const OnboardingText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 32.sp,
        fontWeight: FontWeight.w900,
        height: 1.1,
        letterSpacing: -1.5,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      textAlign: TextAlign.center,
    );
  }
}
