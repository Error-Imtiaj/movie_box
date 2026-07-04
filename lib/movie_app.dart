import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_box/core/const/app_colors.dart';
import 'package:movie_box/core/const/app_strings.dart';
import 'package:movie_box/core/dependency/service_locator.dart';
import 'package:movie_box/core/services/network/bloc/network_bloc.dart';
import 'package:movie_box/core/router/router_navigation.dart';
import 'package:movie_box/core/theme/app_theme.dart';
import 'package:movie_box/feature/home/bloc/home_bloc.dart';
import 'package:movie_box/feature/seeall/bloc/seeall_bloc.dart';
import 'package:movie_box/feature/splash/bloc/splash_bloc.dart';

final GlobalKey<ScaffoldMessengerState> messengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MovieApp extends StatefulWidget {
  const MovieApp({super.key});

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  bool _wasDisconnected = false;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, _) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => getIt<NetworkBloc>()..add(NetworkStarted()),
            ),
            BlocProvider(create: (_) => getIt<SplashBloc>()),
            BlocProvider(create: (_) => getIt<HomeBloc>()),
            BlocProvider(create: (_) => getIt<SeeAllBloc>()),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Movie Box',
            scaffoldMessengerKey: messengerKey,
            theme: AppTheme.lightTheme,
            routerConfig: routerNavigation,
            builder: (context, child) {
              return BlocListener<NetworkBloc, NetworkState>(
                listenWhen: (previous, current) =>
                    previous.runtimeType != current.runtimeType,
                listener: (context, state) {
                  debugPrint('Network listener: ${state.runtimeType}');
                  if (state is NetworkDisconnected) {
                    _wasDisconnected = true;

                    messengerKey.currentState?.removeCurrentSnackBar();
                    if (messengerKey.currentState == null) {
                      debugPrint('ScaffoldMessenger is null');
                      return;
                    }
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      messengerKey.currentState?.showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,

                          backgroundColor: AppColors.error,
                          content: Text(
                            AppStrings.noInternetConnection,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppColors.white),
                          ),
                          duration: Duration(days: 1),
                        ),
                      );
                    });
                  } else if (state is NetworkConnected && _wasDisconnected) {
                    _wasDisconnected = false;
                    messengerKey.currentState?.removeCurrentSnackBar();
                    if (messengerKey.currentState == null) {
                      debugPrint('ScaffoldMessenger is null');
                      return;
                    }
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      messengerKey.currentState?.showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            AppStrings.backOnline,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppColors.white),
                          ),
                          backgroundColor: AppColors.success,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    });
                  }
                },
                child: child!,
              );
            },
          ),
        );
      },
    );
  }
}
