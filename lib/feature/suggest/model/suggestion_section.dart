

import 'package:movie_box/feature/home/model/movie_model.dart';

class SuggestionSection {
  final String title;
  final String subtitle;
  final List<MovieModel> movies;
  final bool showSeeAll;

  const SuggestionSection({
    required this.title,
    required this.subtitle,
    required this.movies,
    this.showSeeAll = false,
  });

  bool get isEmpty => movies.isEmpty;

  int get itemCount => movies.length;

  SuggestionSection copyWith({
    String? title,
    String? subtitle,
    List<MovieModel>? movies,
    bool? showSeeAll,
  }) {
    return SuggestionSection(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      movies: movies ?? this.movies,
      showSeeAll: showSeeAll ?? this.showSeeAll,
    );
  }
}