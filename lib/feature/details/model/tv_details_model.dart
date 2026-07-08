import 'cast_model.dart';
import 'episode_model.dart';
import 'genre_model.dart';
import 'production_company_model.dart';
import 'season_model.dart';
import 'spoken_language_model.dart';
import 'video_model.dart';

class TvDetailsModel {
  final int id;
  final String name;
  final String originalName;
  final String overview;
  final String? tagline;

  final String? posterPath;
  final String? backdropPath;

  final String firstAirDate;
  final String lastAirDate;

  final String status;
  final String type;
  final String originalLanguage;

  final double voteAverage;
  final int voteCount;
  final double popularity;

  final bool adult;
  final bool inProduction;

  final int numberOfEpisodes;
  final int numberOfSeasons;

  final List<int> episodeRunTime;

  final List<GenreModel> genres;
  final List<SeasonModel> seasons;
  final List<ProductionCompanyModel> productionCompanies;
  final List<SpokenLanguageModel> spokenLanguages;

  /// Filled separately from /credits
  final List<CastModel> cast;

  /// Filled separately from /videos
  final List<VideoModel> videos;

  /// Currently selected season episodes
  final List<EpisodeModel> episodes;

  bool get isTv => true;
  bool get isMovie => false;
  String get title => name;
  String? get releaseDate => firstAirDate;
  int? get runtime => episodeRunTime.isNotEmpty ? episodeRunTime.first : null;

  const TvDetailsModel({
    required this.id,
    required this.name,
    required this.originalName,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.firstAirDate,
    required this.lastAirDate,
    required this.status,
    required this.type,
    required this.originalLanguage,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    required this.adult,
    required this.inProduction,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.episodeRunTime,
    required this.genres,
    required this.seasons,
    required this.productionCompanies,
    required this.spokenLanguages,
    this.cast = const [],
    this.videos = const [],
    this.episodes = const [], this.tagline,
  });

  factory TvDetailsModel.fromJson(Map<String, dynamic> json) {
    return TvDetailsModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      tagline: json['tagline'] ?? '',
      originalName: json['original_name'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      firstAirDate: json['first_air_date'] ?? '',
      lastAirDate: json['last_air_date'] ?? '',
      status: json['status'] ?? '',
      type: json['type'] ?? '',
      originalLanguage: json['original_language'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
      popularity: (json['popularity'] ?? 0).toDouble(),
      adult: json['adult'] ?? false,
      inProduction: json['in_production'] ?? false,
      numberOfEpisodes: json['number_of_episodes'] ?? 0,
      numberOfSeasons: json['number_of_seasons'] ?? 0,
      episodeRunTime:
          (json['episode_run_time'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          [],
      genres:
          (json['genres'] as List<dynamic>?)
              ?.map((e) => GenreModel.fromJson(e))
              .toList() ??
          [],
      seasons:
          (json['seasons'] as List<dynamic>?)
              ?.map((e) => SeasonModel.fromJson(e))
              .toList() ??
          [],
      productionCompanies:
          (json['production_companies'] as List<dynamic>?)
              ?.map((e) => ProductionCompanyModel.fromJson(e))
              .toList() ??
          [],
      spokenLanguages:
          (json['spoken_languages'] as List<dynamic>?)
              ?.map((e) => SpokenLanguageModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tagline': tagline,
      'original_name': originalName,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'first_air_date': firstAirDate,
      'last_air_date': lastAirDate,
      'status': status,
      'type': type,
      'original_language': originalLanguage,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'popularity': popularity,
      'adult': adult,
      'in_production': inProduction,
      'number_of_episodes': numberOfEpisodes,
      'number_of_seasons': numberOfSeasons,
      'episode_run_time': episodeRunTime,
      'genres': genres.map((e) => e.toJson()).toList(),
      'seasons': seasons.map((e) => e.toJson()).toList(),
      'production_companies': productionCompanies
          .map((e) => e.toJson())
          .toList(),
      'spoken_languages': spokenLanguages.map((e) => e.toJson()).toList(),
    };
  }

  TvDetailsModel copyWith({
    int? id,
    String? name,
    String? originalName,
    String? overview,
    String? posterPath,
    String? backdropPath,
    String? firstAirDate,
    String? lastAirDate,
    String? status,
    String? tagline,
    String? type,
    String? originalLanguage,
    double? voteAverage,
    int? voteCount,
    double? popularity,
    bool? adult,
    bool? inProduction,
    int? numberOfEpisodes,
    int? numberOfSeasons,
    List<int>? episodeRunTime,
    List<GenreModel>? genres,
    List<SeasonModel>? seasons,
    List<ProductionCompanyModel>? productionCompanies,
    List<SpokenLanguageModel>? spokenLanguages,
    List<CastModel>? cast,
    List<VideoModel>? videos,
    List<EpisodeModel>? episodes,
  }) {
    return TvDetailsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      tagline: tagline ?? this.tagline,
      originalName: originalName ?? this.originalName,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      firstAirDate: firstAirDate ?? this.firstAirDate,
      lastAirDate: lastAirDate ?? this.lastAirDate,
      status: status ?? this.status,
      type: type ?? this.type,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      popularity: popularity ?? this.popularity,
      adult: adult ?? this.adult,
      inProduction: inProduction ?? this.inProduction,
      numberOfEpisodes: numberOfEpisodes ?? this.numberOfEpisodes,
      numberOfSeasons: numberOfSeasons ?? this.numberOfSeasons,
      episodeRunTime: episodeRunTime ?? this.episodeRunTime,
      genres: genres ?? this.genres,
      seasons: seasons ?? this.seasons,
      productionCompanies: productionCompanies ?? this.productionCompanies,
      spokenLanguages: spokenLanguages ?? this.spokenLanguages,
      cast: cast ?? this.cast,
      videos: videos ?? this.videos,
      episodes: episodes ?? this.episodes,
    );
  }
}
