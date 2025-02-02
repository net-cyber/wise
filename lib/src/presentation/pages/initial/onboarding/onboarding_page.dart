import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wise/src/core/constants/app_constants.dart';
import 'package:wise/src/core/router/route_name.dart';
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

class _OnboardingPageState extends State<OnboardingPage> with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  late PageController _pageController;
  late AnimationController _animationController;

  final List<OnboardingItem> _onboardingItems = [
    OnboardingItem(AppConstants.openJar, 'Send and receive\nmoney globally'),
    OnboardingItem(AppConstants.jet, 'Fast and secure\ntransactions'),
    OnboardingItem(AppConstants.glob_coin, 'One account for all\nyour currencies'),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            24.verticalSpace,
            _buildSkipButton(),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _onboardingItems.length,
                itemBuilder: (context, index) {
                  return FadeTransition(
                    opacity: _animationController,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.2, 0),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: _animationController,
                        curve: Curves.easeOut,
                      )),
                      child: _buildPage(_onboardingItems[index]),
                    ),
                  );
                },
              ),
            ),
            40.verticalSpace,
            _buildBottomSection(),
            48.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(right: 24.w),
        child: TextButton(
          onPressed: () => context.pushNamed(RouteName.login),
          child: Text(
            'Skip',
            style: TextStyle(
              fontSize: 16.sp,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingItem item) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OnboardingImage(imagePath: item.image),
          40.verticalSpace,
          OnboardingText(text: item.text),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          _buildPageIndicator(),
          24.verticalSpace,
          if (currentIndex == _onboardingItems.length - 1)
            _buildAuthButtons()
          else
            _buildNextButton(),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _onboardingItems.length,
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          height: 8.h,
          width: currentIndex == index ? 24.w : 8.w,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.primary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: () {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Text(
          'Continue',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildAuthButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 56.h,
          child: ElevatedButton(
            onPressed: () => context.pushNamed(RouteName.register),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            child: Text(
              'Get Started',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        16.verticalSpace,
        TextButton(
          onPressed: () => context.pushNamed(RouteName.login),
          child: Text(
            'I already have an account',
            style: TextStyle(
              fontSize: 16.sp,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
