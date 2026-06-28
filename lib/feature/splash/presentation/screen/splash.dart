import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_box/core/const/app_strings.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movie_box/feature/splash/bloc/splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
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
    FlutterNativeSplash.remove(); // Remove the native splash screen
    _chars = AppStrings.appName.split('');
    final random = Random();
    for (var i = 0; i < _chars.length; i++) {
      final controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 2000),
      );
      final beginOffset = _directions[random.nextInt(_directions.length)];
      final animation = Tween<Offset>(
        begin: beginOffset,
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));
      _controllers.add(controller);
      _animations.add(animation);
      Future.delayed(Duration(milliseconds: i * 100), controller.forward);
    }
    context.read<SplashBloc>().add(SplashStarted());
  }

  @override
  void dispose() {
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
          context.go(AppStrings.onboardingScreen);
        }
        if (state is SplashNavigateToHome) {
          context.go(AppStrings.homeScreen);
        }
      },
      child: Scaffold(
        body: Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            children: List.generate(_chars.length, (i) {
              return FadeTransition(
                opacity: _controllers[i],
                child: SlideTransition(
                  position: _animations[i],
                  child: Text(
                    _chars[i],
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 40.sp,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
