import 'package:flutter/material.dart';
import 'package:wise/src/core/constants/app_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wise App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
