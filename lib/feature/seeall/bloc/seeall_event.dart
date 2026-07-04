part of 'seeall_bloc.dart';


sealed class SeeAllEvent {}

class LoadSeeAllMoviesEvent extends SeeAllEvent {
  final MovieCategory category;
  final String title;

  LoadSeeAllMoviesEvent({
    required this.category,
    required this.title,
  });
}

class LoadMoreMoviesEvent extends SeeAllEvent {}