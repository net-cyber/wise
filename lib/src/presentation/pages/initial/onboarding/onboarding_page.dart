import 'package:flutter/material.dart';
import 'package:wise/src/core/constants/app_constants.dart';
import 'package:wise/src/model/onboarding_item.dart';
import 'package:wise/src/presentation/theme/app_colors.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentIndex = 0; // Track the current index

  // List of onboarding items
  final List<OnboardingItem> _onboardingItems = [
    OnboardingItem(AppConstants.openJar, '175 COUNTRIES. 50\nCURRENCIES. ONE\nACCOUNT'),
    OnboardingItem(AppConstants.jet, 'SEND MONEY AND\nGET PAID FROM\nABROAD'),
    // Add more items as needed
  ];

  void _increaseProgress() {
    setState(() {
      // Increment the current index, ensuring it doesn't exceed the list length
      if (currentIndex < _onboardingItems.length - 1) {
        currentIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Progress bar at top
            LinearProgressIndicator(
              value: (currentIndex + 1) / _onboardingItems.length, // Update progress based on current index
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.onboardingBackgroundDark, // Dark green color
              ),
            ),
            
            // Main content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Jars and coins stack
                    SizedBox(
                      height: 300,
                      child: Image.asset(_onboardingItems[currentIndex].image, height: 300),
                    ),
                    
                    // Text content
                    Text(
                      _onboardingItems[currentIndex].text,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    
                    // Check rates link
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Check our rates',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Get started button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _increaseProgress,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.splashBackground,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Get started',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
