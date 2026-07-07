
part of 'suggest_bloc.dart';

sealed class SuggestEvent {
  const SuggestEvent();
}

final class LoadSuggestions extends SuggestEvent {
  const LoadSuggestions();
}

final class SurpriseMe extends SuggestEvent {
  const SurpriseMe();
}

final class SelectMood extends SuggestEvent {
  final String mood;

  const SelectMood(this.mood);
}

final class SelectGenre extends SuggestEvent {
  final int genreId;

  const SelectGenre(this.genreId);
}

final class LoadMoreSuggestions extends SuggestEvent {
  const LoadMoreSuggestions();
}

final class RefreshSuggestions extends SuggestEvent {
  const RefreshSuggestions();
}
