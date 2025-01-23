import 'package:flutter/material.dart';
import 'package:wise/src/core/constants/app_constants.dart';
import 'package:wise/src/model/onboarding_item.dart';
import 'package:wise/src/presentation/pages/initial/onboarding/widget/buttons/apple_signin_button.dart';
import 'package:wise/src/presentation/pages/initial/onboarding/widget/buttons/authentication_buttons.dart';
import 'package:wise/src/presentation/pages/initial/onboarding/widget/buttons/check_rates_button.dart';
import 'package:wise/src/presentation/pages/initial/onboarding/widget/buttons/custom_button.dart';
import 'package:wise/src/presentation/pages/initial/onboarding/widget/buttons/get_started_button.dart';
import 'package:wise/src/presentation/pages/initial/onboarding/widget/extras/onboarding_imgae.dart';
import 'package:wise/src/presentation/pages/initial/onboarding/widget/extras/progress_indicator.dart';
import 'package:wise/src/presentation/pages/initial/onboarding/widget/texts/onboarding_text.dart';
import 'package:wise/src/presentation/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 50.h),
            OnboardingProgressIndicator(
              currentIndex: currentIndex,
              totalItems: _onboardingItems.length,
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OnboardingImage(
                      imagePath: _onboardingItems[currentIndex].image,
                    ),
                    SizedBox(height: 60.h),
                    OnboardingText(
                      text: _onboardingItems[currentIndex].text,
                    ),
                    SizedBox(height: 40.h),
                    if (!isLastPage) ...[
                      
                      SizedBox(height: 20.h),
                      GetStartedButton(onPressed: _increaseProgress, context: context),
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
