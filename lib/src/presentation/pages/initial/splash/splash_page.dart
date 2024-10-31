import 'package:flutter/material.dart';
import 'package:wise/src/core/constants/app_constants.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB4E878), // Light green background
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo in the center
          Center(
            child: Image.asset(
              AppConstants.wiseLogo,
              width: 100,
              height: 100,
            ),
          ),
          

         
        ],
      ),
    );
  }
}
