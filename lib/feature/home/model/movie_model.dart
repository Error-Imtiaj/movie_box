class MovieModel {
  final int id;
  final String title;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String originalLanguage;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  final double popularity;
  final List<int> genreIds;
  final bool adult;
  final bool video;
  final String? mediaType;

  MovieModel({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.originalLanguage,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    required this.genreIds,
    required this.adult,
    required this.video,
    this.mediaType,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json["id"],
      title: json['title'] ?? json['name'] ?? '',
      originalTitle: json['original_title'] ?? json['original_name'] ?? '',
      overview: json["overview"] ?? "",
      posterPath: json["poster_path"] ?? "",
      backdropPath: json["backdrop_path"] ?? "",
      originalLanguage: json["original_language"] ?? "",
      releaseDate: json['release_date'] ?? json['first_air_date'] ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json["vote_count"] ?? 0,
      popularity: (json["popularity"] as num?)?.toDouble() ?? 0.0,
      genreIds: List<int>.from(json["genre_ids"] ?? []),
      adult: json["adult"] ?? false,
      video: json["video"] ?? false,
      mediaType:
          json['media_type'] ?? (json.containsKey('title') ? 'movie' : 'tv'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'original_title': originalTitle,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'original_language': originalLanguage,
      'release_date': releaseDate,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'popularity': popularity,
      'genre_ids': genreIds,
      'adult': adult,
      'video': video,
      'media_type': mediaType,
    };
  }
}
