

class SuggestionFilter {
  final String? mood;
  final int? genreId;
  final int? runtime;
  final String sortBy;
  final int page;

  const SuggestionFilter({
    this.mood,
    this.genreId,
    this.runtime,
    this.sortBy = 'popularity.desc',
    this.page = 1,
  });

  bool get hasFilter =>
      mood != null ||
      genreId != null ||
      runtime != null;

  SuggestionFilter copyWith({
    String? mood,
    int? genreId,
    int? runtime,
    String? sortBy,
    int? page,
  }) {
    return SuggestionFilter(
      mood: mood ?? this.mood,
      genreId: genreId ?? this.genreId,
      runtime: runtime ?? this.runtime,
      sortBy: sortBy ?? this.sortBy,
      page: page ?? this.page,
    );
  }

  Map<String, dynamic> toQueryParameters() {
    final query = <String, dynamic>{
      'page': page,
      'sort_by': sortBy,
      'include_adult': false,
      'vote_count.gte': 100,
    };

    if (genreId != null) {
      query['with_genres'] = genreId;
    }

    if (runtime != null) {
      if (runtime == 90) {
        query['with_runtime.lte'] = 90;
      } else if (runtime == 120) {
        query['with_runtime.gte'] = 90;
        query['with_runtime.lte'] = 120;
      } else if (runtime == 180) {
        query['with_runtime.gte'] = 120;
      }
    }

    return query;
  }
}