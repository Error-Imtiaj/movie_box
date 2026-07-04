part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class SubmitApiKeyEvent extends HomeEvent {
  final String apiKey;

  SubmitApiKeyEvent(this.apiKey);

}



class LoadHomeEvent extends HomeEvent {}
class LoadMoreMoviesEvent extends HomeEvent {
  final MovieCategory category;

  LoadMoreMoviesEvent(this.category);
}