part of 'seeall_bloc.dart';

sealed class SeeAllState {}

class SeeAllInitial extends SeeAllState {}

class SeeAllLoading extends SeeAllState {}

class SeeAllLoaded extends SeeAllState {
  final List<MovieModel> movies;
  final bool hasReachedMax;
  final bool isLoadingMore;

   SeeAllLoaded({
    required this.movies,
    required this.hasReachedMax,
    this.isLoadingMore = false,
  });

  SeeAllLoaded copyWith({
    List<MovieModel>? movies,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return SeeAllLoaded(
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class SeeAllError extends SeeAllState {
  final String message;

  SeeAllError(this.message);
}
