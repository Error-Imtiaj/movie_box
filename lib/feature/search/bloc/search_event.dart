part of 'search_bloc.dart';

sealed class SearchEvent {
  const SearchEvent();
}

final class SearchMovies extends SearchEvent {
  final String query;

  const SearchMovies(this.query);
}

final class ClearSearch extends SearchEvent {
  const ClearSearch();
}

final class LoadRecentSearch extends SearchEvent {
  const LoadRecentSearch();
}

final class RemoveRecentSearch extends SearchEvent {
  final String query;

  const RemoveRecentSearch(this.query);
}
