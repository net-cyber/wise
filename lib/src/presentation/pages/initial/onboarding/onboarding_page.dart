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
    OnboardingItem(AppConstants.glob_coin, 'ONE ACCOUNT\nFOR ALL THE\nMONEY IN THE\nWORLD'),
   
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
    bool isLastPage = currentIndex == _onboardingItems.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Progress bar at top
            LinearProgressIndicator(
              value: (currentIndex + 1) / _onboardingItems.length,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.onboardingBackgroundDark, 
              ),
            ),
            
            // Main content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image
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
                    const Spacer(),
                    
                    // Conditional rendering for buttons
                    if (!isLastPage) ...[
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
                              borderRadius: BorderRadius.circular(25),
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
                    ] else ...[
                      // Login and Register buttons in a row
                      Row(
                        children: [
                          // Login button
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigate to login page
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.splashBackground,
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: const Text(
                                'Log in',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12), // Space between buttons
                          // Register button
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigate to register page
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.splashBackground,
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Sign in with Apple button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle Apple sign in
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               Icon(Icons.apple, color: Colors.white),
                               SizedBox(width: 8),
                               Text(
                                'Sign in with Apple',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
