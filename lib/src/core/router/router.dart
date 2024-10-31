import 'package:go_router/go_router.dart';
import 'package:wise/src/core/router/route_name.dart';
import 'package:wise/src/presentation/pages/initial/onboarding/onboarding_page.dart';
import 'package:wise/src/presentation/pages/initial/splash/splash_page.dart';


// GoRouter configuration
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
      builder: (context, state) =>  OnboardingPage(),
    ),
  ],
);