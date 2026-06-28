import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_box/core/network/services/network_service.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  final NetworkService networkService;

  StreamSubscription? _subscription;

  NetworkBloc(this.networkService) : super(NetworkInitial()) {
    on<NetworkStarted>(_onStarted);

    on<NetworkStatusChanged>(_onStatusChanged);
  }

  Future<void> _onStarted(
    NetworkStarted event,

    Emitter<NetworkState> emit,
  ) async {
    final connected = await networkService.hasInternet;
    emit(connected ? NetworkConnected() : NetworkDisconnected());
    _subscription = networkService.onNetworkChanged.listen((status) {
      add(NetworkStatusChanged(status));
    });
  }

  void _onStatusChanged(
    NetworkStatusChanged event,
    Emitter<NetworkState> emit,
  ) {
    emit(event.isConnected ? NetworkConnected() : NetworkDisconnected());
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
