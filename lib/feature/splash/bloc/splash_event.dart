part of 'splash_bloc.dart';

@immutable
sealed class SplashEvent {}

final class SplashStarted extends SplashEvent {}