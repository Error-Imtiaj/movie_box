import 'dart:convert';

import 'genre_model.dart';

class MovieDetailsModel {
  final int id;
  final bool adult;
  final String title;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String releaseDate;
  final int runtime;
  final String status;
  final String tagline;
  final String originalLanguage;
  final double voteAverage;
  final int voteCount;
  final double popularity;
  final int budget;
  final int revenue;
  final List<GenreModel> genres;

  bool get isMovie => true;
  bool get isTv => false;
  const MovieDetailsModel({
    required this.id,
    required this.adult,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.runtime,
    required this.status,
    required this.tagline,
    required this.originalLanguage,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    required this.budget,
    required this.revenue,
    required this.genres,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      id: json["id"] ?? 0,
      adult: json["adult"] ?? false,
      title: json["title"] ?? "",
      originalTitle: json["original_title"] ?? "",
      overview: json["overview"] ?? "",
      posterPath: json["poster_path"] ?? "",
      backdropPath: json["backdrop_path"] ?? "",
      releaseDate: json["release_date"] ?? "",
      runtime: json["runtime"] ?? 0,
      status: json["status"] ?? "",
      tagline: json["tagline"] ?? "",
      originalLanguage: json["original_language"] ?? "",
      voteAverage: (json["vote_average"] ?? 0).toDouble(),
      voteCount: json["vote_count"] ?? 0,
      popularity: (json["popularity"] ?? 0).toDouble(),
      budget: json["budget"] ?? 0,
      revenue: json["revenue"] ?? 0,
      genres: (json["genres"] as List? ?? [])
          .map((e) => GenreModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "adult": adult,
      "title": title,
      "original_title": originalTitle,
      "overview": overview,
      "poster_path": posterPath,
      "backdrop_path": backdropPath,
      "release_date": releaseDate,
      "runtime": runtime,
      "status": status,
      "tagline": tagline,
      "original_language": originalLanguage,
      "vote_average": voteAverage,
      "vote_count": voteCount,
      "popularity": popularity,
      "budget": budget,
      "revenue": revenue,
      "genres": genres.map((e) => e.toJson()).toList(),
    };
  }

  factory MovieDetailsModel.fromRawJson(String source) =>
      MovieDetailsModel.fromJson(json.decode(source));

  String toRawJson() => json.encode(toJson());

  MovieDetailsModel copyWith({
    int? id,
    bool? adult,
    String? title,
    String? originalTitle,
    String? overview,
    String? posterPath,
    String? backdropPath,
    String? releaseDate,
    int? runtime,
    String? status,
    String? tagline,
    String? originalLanguage,
    double? voteAverage,
    int? voteCount,
    double? popularity,
    int? budget,
    int? revenue,
    List<GenreModel>? genres,
  }) {
    return MovieDetailsModel(
      id: id ?? this.id,
      adult: adult ?? this.adult,
      title: title ?? this.title,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      releaseDate: releaseDate ?? this.releaseDate,
      runtime: runtime ?? this.runtime,
      status: status ?? this.status,
      tagline: tagline ?? this.tagline,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      popularity: popularity ?? this.popularity,
      budget: budget ?? this.budget,
      revenue: revenue ?? this.revenue,
      genres: genres ?? this.genres,
    );
  }

  @override
  String toString() {
    return 'MovieDetailsModel(id: $id, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MovieDetailsModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
