part of 'favourite_bloc.dart';

@immutable
sealed class FavouriteState {
  const FavouriteState();
}

final class FavouriteInitial extends FavouriteState {
  const FavouriteInitial();
}

final class FavouriteLoading extends FavouriteState {
  const FavouriteLoading();
}

final class FavouriteLoaded extends FavouriteState {
  final List<MovieModel> movies;

  const FavouriteLoaded(this.movies);
}

final class FavouriteError extends FavouriteState {
  final String message;

  const FavouriteError(this.message);
}
