import 'package:get_it/get_it.dart';
import 'package:movie_box/core/network/bloc/network_bloc.dart';
import 'package:movie_box/core/network/services/network_service.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  static Future<void> init() async{
    getIt.registerSingleton<NetworkService>(NetworkService());
    getIt.registerSingleton<NetworkBloc>(NetworkBloc(getIt<NetworkService>()));
  }
}