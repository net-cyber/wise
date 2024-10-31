import 'package:flutter/material.dart';
import 'package:wise/src/core/constants/app_constants.dart';
import 'package:wise/src/model/onboarding_item.dart';
import 'package:wise/src/presentation/pages/initial/onboarding/components/buttons/apple_signin_button.dart';
import 'package:wise/src/presentation/pages/initial/onboarding/components/buttons/authentication_buttons.dart';
import 'package:wise/src/presentation/pages/initial/onboarding/components/buttons/check_rates_button.dart';
import 'package:wise/src/presentation/pages/initial/onboarding/components/buttons/custom_button.dart';
import 'package:wise/src/presentation/pages/initial/onboarding/components/buttons/get_started_button.dart';
import 'package:wise/src/presentation/pages/initial/onboarding/components/extras/onboarding_imgae.dart';
import 'package:wise/src/presentation/pages/initial/onboarding/components/extras/progress_indicator.dart';
import 'package:wise/src/presentation/pages/initial/onboarding/components/texts/onboarding_text.dart';
import 'package:wise/src/presentation/theme/app_colors.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentIndex = 0;

  final List<OnboardingItem> _onboardingItems = [
    OnboardingItem(AppConstants.openJar, '175 COUNTRIES. 50\nCURRENCIES. ONE\nACCOUNT'),
    OnboardingItem(AppConstants.jet, 'SEND MONEY AND\nGET PAID FROM\nABROAD'),
    OnboardingItem(AppConstants.glob_coin, 'ONE ACCOUNT\nFOR ALL THE\nMONEY IN THE\nWORLD'),
  ];

  void _increaseProgress() {
    setState(() {
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
            OnboardingProgressIndicator(
              currentIndex: currentIndex,
              totalItems: _onboardingItems.length,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OnboardingImage(
                      imagePath: _onboardingItems[currentIndex].image,
                    ),
                    OnboardingText(
                      text: _onboardingItems[currentIndex].text,
                    ),
                    const Spacer(),
                    if (!isLastPage) ...[
                      CheckRatesButton(onPressed: _increaseProgress),
                      const SizedBox(height: 20),
                      GetStartedButton(onPressed: _increaseProgress),
                    ] else ...[
                      const AuthenticationButtons(),
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
