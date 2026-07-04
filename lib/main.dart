import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movie_box/bloc_observer.dart';
import 'package:movie_box/core/dependency/service_locator.dart';
import 'package:movie_box/movie_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);

  Bloc.observer = AppBlocObserver();
  await dotenv.load(fileName: ".env");
  print(dotenv.env);
  await ServiceLocator.init();
  debugPrint('Observer: ${Bloc.observer.runtimeType}');

  // Preload any Google Fonts that are already referenced in the app.
  // This only waits for locally bundled or cached fonts and does not
  // require an internet connection.
  //await GoogleFonts.pendingFonts();

  runApp(const MovieApp());
}
