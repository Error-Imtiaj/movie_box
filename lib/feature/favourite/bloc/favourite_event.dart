part of 'favourite_bloc.dart';


@immutable
sealed class FavouriteEvent {
  const FavouriteEvent();
}

final class LoadFavourites extends FavouriteEvent {
  const LoadFavourites();
}

final class AddFavourite extends FavouriteEvent {
  final MovieModel movie;

  const AddFavourite(this.movie);
}

final class RemoveFavourite extends FavouriteEvent {
  final int movieId;

  const RemoveFavourite(this.movieId);
}

final class ToggleFavourite extends FavouriteEvent {
  final MovieModel movie;

  const ToggleFavourite(this.movie);
}

final class ClearFavourites extends FavouriteEvent {
  const ClearFavourites();
}
