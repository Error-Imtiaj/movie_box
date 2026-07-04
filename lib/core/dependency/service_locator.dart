import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_box/core/services/local_storage/services/local_storage_service.dart';
import 'package:movie_box/core/services/network/bloc/network_bloc.dart';
import 'package:movie_box/core/services/network/services/dio_client.dart';
import 'package:movie_box/core/services/network/services/network_service.dart';
import 'package:movie_box/feature/home/bloc/home_bloc.dart';
import 'package:movie_box/feature/home/repository/home_repository.dart';
import 'package:movie_box/feature/seeall/bloc/seeall_bloc.dart';
import 'package:movie_box/feature/splash/bloc/splash_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  static Future<void> init() async {
    // REGISTER FACTORY MEANS A NEW INSTANCE WILL BE CREATED EACH TIME IT IS REQUESTED
    // REGISTER SINGLETON MEANS THE SAME INSTANCE WILL BE USED EACH TIME IT IS REQUESTED
    // REGISTER LAZY SINGLETON MEANS THE INSTANCE WILL BE CREATED WHEN IT IS FIRST REQUESTED
    // REGISTER ASYNC MEANS THE INSTANCE WILL BE CREATED ASYNCHRONOUSLY WHEN IT IS FIRST REQUESTED
    // REGISTER ASYNC SINGLETON MEANS THE INSTANCE WILL BE CREATED ASYNCHRONOUSLY WHEN IT IS FIRST REQUESTED AND THE SAME INSTANCE WILL BE USED EACH TIME IT IS REQUESTED
    // REGISTER ASYNC LAZY SINGLETON MEANS THE INSTANCE WILL BE CREATED ASYNCHRONOUSLY WHEN IT IS FIRST REQUESTED AND THE SAME INSTANCE WILL BE USED EACH TIME IT IS REQUESTED
    // REGISTER ASYNC FACTORY MEANS A NEW INSTANCE WILL BE CREATED ASYNCHRONOUSLY EACH TIME IT IS REQUESTED

    final prefs = await SharedPreferences.getInstance();
    getIt.registerSingleton<NetworkService>(NetworkService());
    getIt.registerSingleton<NetworkBloc>(NetworkBloc(getIt<NetworkService>()));
    getIt.registerSingleton<LocalStorageService>(LocalStorageService(prefs));

    // SPLASH BLOC
    getIt.registerSingleton<SplashBloc>(
      SplashBloc(getIt<LocalStorageService>()),
    );

    // DIO CLIENT
    getIt.registerLazySingleton(() => DioClient());
    getIt.registerLazySingleton(() => getIt<DioClient>().dio);

    // HOME REPOSITORY
    getIt.registerLazySingleton(() => HomeRepository(getIt<Dio>()));

    // HOME BLOC
    getIt.registerFactory(
      () => HomeBloc(getIt<HomeRepository>(), getIt<LocalStorageService>()),
    );

    // SEE ALL BLOC
    getIt.registerFactory(() => SeeAllBloc(getIt<HomeRepository>()));
  }
}
