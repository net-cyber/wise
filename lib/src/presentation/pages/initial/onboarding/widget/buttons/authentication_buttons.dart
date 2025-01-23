import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wise/src/core/router/route_name.dart';
import 'package:wise/src/presentation/theme/app_colors.dart';
import 'package:wise/src/presentation/pages/initial/onboarding/widget/buttons/apple_signin_button.dart';
import 'package:wise/src/presentation/pages/initial/onboarding/widget/buttons/custom_button.dart';

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
                context: context,
                onPressed: () {
                  context.pushNamed(RouteName.login);
                },
                text: 'Log in',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomButton(
                context: context,
                onPressed: () {
                  context.pushNamed(RouteName.register);
                },
                text: 'Register',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        
      ],
    );
  }
}



