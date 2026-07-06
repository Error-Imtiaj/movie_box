part of 'search_bloc.dart';

sealed class SearchState {
  const SearchState();
}

final class SearchInitial extends SearchState {
  const SearchInitial();
}

final class SearchLoading extends SearchState {
  const SearchLoading();
}

final class SearchLoaded extends SearchState {
  final List<MovieModel> movies;

  const SearchLoaded(this.movies);
}

final class SearchEmpty extends SearchState {
  const SearchEmpty();
}

final class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);
}
