import 'package:flutter/material.dart';
import 'package:wise/src/presentation/theme/app_colors.dart';
import 'package:wise/src/presentation/pages/initial/onboarding/components/buttons/apple_signin_button.dart';
import 'package:wise/src/presentation/pages/initial/onboarding/components/buttons/custom_button.dart';

class AuthenticationButtons extends StatelessWidget {
  const AuthenticationButtons();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomButton(
                onPressed: () {},
                text: 'Log in',
                backgroundColor: AppColors.splashBackground,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomButton(
                onPressed: () {},
                text: 'Register',
                backgroundColor: AppColors.splashBackground,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        AppleSignInButton(),
      ],
    );
  }
}



