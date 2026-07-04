part of 'seeall_bloc.dart';



sealed class SeeAllState {}

class SeeAllInitial extends SeeAllState {}

class SeeAllLoading extends SeeAllState {}

class SeeAllLoaded extends SeeAllState {
  final List<MovieModel> movies;
  final bool hasReachedMax;

   SeeAllLoaded({
    required this.movies,
    required this.hasReachedMax,
  });

  SeeAllLoaded copyWith({
    List<MovieModel>? movies,
    bool? hasReachedMax,
  }) {
    return SeeAllLoaded(
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class SeeAllError extends SeeAllState {
  final String message;

  SeeAllError(this.message);
}