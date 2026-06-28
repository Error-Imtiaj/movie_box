import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_box/core/router/routes.dart';
import 'package:movie_box/feature/home/presentation/screen/home_screen.dart';
import 'package:movie_box/feature/onboarding/presentation/screen/onboarding.dart';
import 'package:movie_box/feature/splash/presentation/screen/splash.dart';

final observer = RouteObserver();
final routerNavigation = GoRouter(
  observers: [observer],
  initialLocation: Routes.splashScreen,
  routes: [
    GoRoute(
      path: Routes.splashScreen,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: Routes.onboardingScreen,
      builder: (context, state) => const Onboarding(),
    ),
    GoRoute(
      path: Routes.homeScreen,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
