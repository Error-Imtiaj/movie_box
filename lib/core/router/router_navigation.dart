import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_box/core/dependency/service_locator.dart';
import 'package:movie_box/core/router/routes.dart';
import 'package:movie_box/feature/home/presentation/screen/home_screen.dart';
import 'package:movie_box/feature/navigator/presentation/screens/navigator_screen.dart';
import 'package:movie_box/feature/onboarding/presentation/screen/onboarding.dart';
import 'package:movie_box/feature/seeall/bloc/seeall_bloc.dart';
import 'package:movie_box/feature/seeall/model/see_all_aurgument_model.dart';
import 'package:movie_box/feature/seeall/presentation/screens/see_all_screen.dart';
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
    GoRoute(
      path: Routes.navigatorScreen,
      builder: (context, state) => const NavigatorScreen(),
    ),
    GoRoute(
      path: Routes.seeAllScreen,
      name: Routes.seeAllScreen,
      builder: (context, state) {
        final extra = state.extra as SeeAllArguments;

        return BlocProvider(
          create: (_) => getIt<SeeAllBloc>()
            ..add(
              LoadSeeAllMoviesEvent(
                category: extra.category,
                title: extra.title,
              ),
            ),
          child: SeeAllScreen(arguments: extra),
        );
      },
    ),
  ],
);
