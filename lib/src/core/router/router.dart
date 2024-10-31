import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wise/src/core/router/route_name.dart';
import 'package:wise/src/presentation/pages/home/card/card_page.dart';
import 'package:wise/src/presentation/pages/home/home_page.dart';
import 'package:wise/src/presentation/pages/home/shell_page.dart';
import 'package:wise/src/presentation/pages/initial/onboarding/onboarding_page.dart';
import 'package:wise/src/presentation/pages/initial/splash/splash_page.dart';

final router = GoRouter(
  initialLocation: '/${RouteName.splash}',
  routes: [
    // Splash
    GoRoute(
      name: RouteName.splash,
      path: '/${RouteName.splash}',
      builder: (context, state) => const SplashPage(),
    ),

    // Onboarding
    GoRoute(
      name: RouteName.onboarding,
      path: '/${RouteName.onboarding}',
      builder: (context, state) => OnboardingPage(),
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
