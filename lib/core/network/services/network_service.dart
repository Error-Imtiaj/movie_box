import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkService {
  final Connectivity _connectivity = Connectivity();

  Stream<bool> get onNetworkChanged {
    return _connectivity.onConnectivityChanged.asyncMap((_) async {
      return await InternetConnection().hasInternetAccess;
    }).distinct();
  }

  Future<bool> get hasInternet async {
    return InternetConnection().hasInternetAccess;
  }
}