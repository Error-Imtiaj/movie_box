import 'dart:convert';

class EpisodeModel {
  final int id;
  final String name;
  final String overview;
  final int episodeNumber;
  final int seasonNumber;
  final String? stillPath;
  final String airDate;
  final int runtime;
  final double voteAverage;
  final int voteCount;

  const EpisodeModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.episodeNumber,
    required this.seasonNumber,
    required this.stillPath,
    required this.airDate,
    required this.runtime,
    required this.voteAverage,
    required this.voteCount,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      overview: json['overview'] ?? '',
      episodeNumber: json['episode_number'] ?? 0,
      seasonNumber: json['season_number'] ?? 0,
      stillPath: json['still_path'],
      airDate: json['air_date'] ?? '',
      runtime: json['runtime'] ?? 0,
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'overview': overview,
        'episode_number': episodeNumber,
        'season_number': seasonNumber,
        'still_path': stillPath,
        'air_date': airDate,
        'runtime': runtime,
        'vote_average': voteAverage,
        'vote_count': voteCount,
      };

  factory EpisodeModel.fromRawJson(String source) =>
      EpisodeModel.fromJson(json.decode(source));

  String toRawJson() => json.encode(toJson());

  EpisodeModel copyWith({
    int? id,
    String? name,
    String? overview,
    int? episodeNumber,
    int? seasonNumber,
    String? stillPath,
    String? airDate,
    int? runtime,
    double? voteAverage,
    int? voteCount,
  }) {
    return EpisodeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      overview: overview ?? this.overview,
      episodeNumber: episodeNumber ?? this.episodeNumber,
      seasonNumber: seasonNumber ?? this.seasonNumber,
      stillPath: stillPath ?? this.stillPath,
      airDate: airDate ?? this.airDate,
      runtime: runtime ?? this.runtime,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
    );
  }

  @override
  String toString() {
    return 'EpisodeModel(id: $id, name: $name, episodeNumber: $episodeNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is EpisodeModel &&
            other.id == id &&
            other.name == name &&
            other.episodeNumber == episodeNumber &&
            other.seasonNumber == seasonNumber &&
            other.stillPath == stillPath;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        episodeNumber.hashCode ^
        seasonNumber.hashCode ^
        stillPath.hashCode;
  }
}