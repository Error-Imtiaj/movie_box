part of 'network_bloc.dart';

@immutable
sealed class NetworkState {}

final class NetworkInitial extends NetworkState {}

class NetworkConnected extends NetworkState {}

class NetworkDisconnected extends NetworkState {}
