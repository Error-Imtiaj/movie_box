part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

// CHECK API STATE
class HomeApiValid extends HomeState {}

class HomeApiInvalid extends HomeState {

  final String message;
  HomeApiInvalid(this.message);

}