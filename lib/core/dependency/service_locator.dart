import 'package:get_it/get_it.dart';
import 'package:movie_box/core/services/local_storage/services/local_storage_service.dart';
import 'package:movie_box/core/services/network/bloc/network_bloc.dart';
import 'package:movie_box/core/services/network/services/network_service.dart';
import 'package:movie_box/feature/splash/bloc/splash_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    getIt.registerSingleton<NetworkService>(NetworkService());
    getIt.registerSingleton<NetworkBloc>(NetworkBloc(getIt<NetworkService>()));

    getIt.registerSingleton<LocalStorageService>(LocalStorageService(prefs));

    // SPLASH BLOC
    getIt.registerSingleton<SplashBloc>(
      SplashBloc(getIt<LocalStorageService>()),
    );
  }
}
