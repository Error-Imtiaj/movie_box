import 'episode_model.dart';

class SeasonModel {
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;
  final int episodeCount;
  final String airDate;
  final double voteAverage;
  final List<EpisodeModel> episodes;

  const SeasonModel({
    required this.id,
    required this.name,
    required this.overview,
    this.posterPath,
    required this.seasonNumber,
    required this.episodeCount,
    required this.airDate,
    required this.voteAverage,
    this.episodes = const [],
  });

  factory SeasonModel.fromJson(Map<String, dynamic> json) {
    return SeasonModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'],
      seasonNumber: json['season_number'] ?? 0,
      episodeCount: json['episode_count'] ?? 0,
      airDate: json['air_date'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      episodes: (json['episodes'] as List<dynamic>?)
              ?.map((e) => EpisodeModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'overview': overview,
      'poster_path': posterPath,
      'season_number': seasonNumber,
      'episode_count': episodeCount,
      'air_date': airDate,
      'vote_average': voteAverage,
      'episodes': episodes.map((e) => e.toJson()).toList(),
    };
  }

  SeasonModel copyWith({
    int? id,
    String? name,
    String? overview,
    String? posterPath,
    int? seasonNumber,
    int? episodeCount,
    String? airDate,
    double? voteAverage,
    List<EpisodeModel>? episodes,
  }) {
    return SeasonModel(
      id: id ?? this.id,
      name: name ?? this.name,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      seasonNumber: seasonNumber ?? this.seasonNumber,
      episodeCount: episodeCount ?? this.episodeCount,
      airDate: airDate ?? this.airDate,
      voteAverage: voteAverage ?? this.voteAverage,
      episodes: episodes ?? this.episodes,
    );
  }
}