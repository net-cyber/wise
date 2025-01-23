import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wise/src/core/router/route_name.dart';
import 'package:wise/src/presentation/pages/auth/login/login_page.dart';
import 'package:wise/src/presentation/pages/auth/register/register_page.dart';
import 'package:wise/src/presentation/pages/initial/splash/splash_page.dart';
import 'package:wise/src/presentation/pages/main/card/card_page.dart';
import 'package:wise/src/presentation/pages/main/home/home_page.dart';
import 'package:wise/src/presentation/pages/main/shell_page.dart';
import 'package:wise/src/presentation/pages/initial/onboarding/onboarding_page.dart';
import 'package:wise/src/presentation/pages/initial/drag_onboarding/drag_onboarding_page.dart';

final router = GoRouter(
  initialLocation: '/${RouteName.splash}',
  routes: [
    // Splash
    GoRoute(
      name: RouteName.splash,
      path: '/${RouteName.splash}',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      name: RouteName.dragOnboarding,
      path: '/${RouteName.dragOnboarding}',
      builder: (context, state) => const DragOnboardingPage(),
    ),
    // Onboarding
    GoRoute(
      name: RouteName.onboarding,
      path: '/${RouteName.onboarding}',
      builder: (context, state) => OnboardingPage(),
    ),
    // Login
    GoRoute(
      name: RouteName.login,
      path: '/${RouteName.login}',
      builder: (context, state) => const LoginPage(),
    ),

    // Register
    GoRoute(
      name: RouteName.register,
      path: '/${RouteName.register}',
      builder: (context, state) => const RegisterPage(),
    ),

    // Shell Route
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ShellPage(navigationShell: navigationShell);
      },
      branches: [
        // Home Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: RouteName.home,
              path: '/${RouteName.home}',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        // Card Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: RouteName.card,
              path: '/${RouteName.card}',
              builder: (context, state) => const CardPage(),
            ),
          ],
        ),
        // Send Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: RouteName.send,
              path: '/${RouteName.send}',
              builder: (context, state) => const Scaffold(), // Replace with SendPage
            ),
          ],
        ),
        // Recipients Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: RouteName.recipients,
              path: '/${RouteName.recipients}',
              builder: (context, state) => const Scaffold(), // Replace with RecipientsPage
            ),
          ],
        ),
        // Manage Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: RouteName.manage,
              path: '/${RouteName.manage}',
              builder: (context, state) => const Scaffold(), // Replace with ManagePage
            ),
          ],
        ),
      ],
    ),
  ],
);
