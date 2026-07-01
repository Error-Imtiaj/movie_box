import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_box/core/const/app_asset.dart';
import 'package:movie_box/core/const/app_size.dart';
import 'package:movie_box/core/const/app_strings.dart';
import 'package:movie_box/core/router/routes.dart';
import 'package:movie_box/feature/splash/bloc/splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  /// Logo Animation
  late AnimationController _logoController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  /// Text Animation
  final List<AnimationController> _controllers = [];
  final List<Animation<Offset>> _animations = [];
  late final List<String> _chars;

  static const _directions = [
    Offset(-3, 0),
    Offset(3, 0),
    Offset(0, -3),
    Offset(0, 3),
    Offset(-2, -2),
    Offset(2, -2),
    Offset(-2, 2),
    Offset(2, 2),
  ];

  @override
  void initState() {
    super.initState();

    FlutterNativeSplash.remove();

    /// Logo Animation
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.elasticOut,
      ),
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.easeIn,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, .25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.easeOut,
      ),
    );

    _logoController.forward();

    /// Animated App Name
    _chars = AppStrings.appName.split('');
    final random = Random();

    for (var i = 0; i < _chars.length; i++) {
      final controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1800),
      );

      final animation = Tween<Offset>(
        begin: _directions[random.nextInt(_directions.length)],
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.elasticOut,
        ),
      );

      _controllers.add(controller);
      _animations.add(animation);

      Future.delayed(
        Duration(milliseconds: i * 80),
        controller.forward,
      );
    }

    context.read<SplashBloc>().add(SplashStarted());
  }

  @override
  void dispose() {
    _logoController.dispose();

    for (final controller in _controllers) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashNavigateToOnboarding) {
          context.go(Routes.onboardingScreen);
        }

        if (state is SplashNavigateToHome) {
          context.go(Routes.homeScreen);
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: _logoController,
                          builder: (_, __) {
                            return Container(
                              width: 100.w,
                              height: 100.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.08),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary.withOpacity(0.25),
                                    blurRadius: 50,
                                    spreadRadius: 12,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),

                        SvgPicture.asset(
                          AppAsset.splash,
                          width: AppSize.splashLogoWidth.w,
                          height: AppSize.splashLogoHeight.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Wrap(
                alignment: WrapAlignment.center,
                children: List.generate(_chars.length, (i) {
                  return FadeTransition(
                    opacity: _controllers[i],
                    child: SlideTransition(
                      position: _animations[i],
                      child: Text(
                        _chars[i],
                        style: Theme.of(context).textTheme.displayLarge
                            ?.copyWith(
                              fontSize: 42.sp,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}