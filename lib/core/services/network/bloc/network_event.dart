part of 'network_bloc.dart';

@immutable
sealed class NetworkEvent {}

class NetworkStarted extends NetworkEvent {}

class NetworkStatusChanged extends NetworkEvent {
  final bool isConnected;

  NetworkStatusChanged(this.isConnected);
}
