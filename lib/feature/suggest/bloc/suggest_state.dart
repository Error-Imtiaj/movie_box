
part of 'suggest_bloc.dart';

sealed class SuggestState {
  const SuggestState();
}

final class SuggestInitial extends SuggestState {
  const SuggestInitial();
}

final class SuggestLoading extends SuggestState {
  const SuggestLoading();
}

final class SuggestLoaded extends SuggestState {
  final List<MovieModel> recommendations;
  final String? selectedMood;
  final int? selectedGenreId;
  final bool isLoadingMore;
  final bool hasReachedMax;

  const SuggestLoaded({
    required this.recommendations,
    this.selectedMood,
    this.selectedGenreId,
    this.isLoadingMore = false,
    this.hasReachedMax = false,
  });

  SuggestLoaded copyWith({
    List<MovieModel>? recommendations,
    String? selectedMood,
    int? selectedGenreId,
    bool? isLoadingMore,
    bool? hasReachedMax,
  }) {
    return SuggestLoaded(
      recommendations: recommendations ?? this.recommendations,
      selectedMood: selectedMood ?? this.selectedMood,
      selectedGenreId: selectedGenreId ?? this.selectedGenreId,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

final class SuggestError extends SuggestState {
  final String message;

  const SuggestError(this.message);
}
