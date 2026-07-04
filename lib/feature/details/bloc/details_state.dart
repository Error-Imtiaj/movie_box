part of 'details_bloc.dart';

sealed class DetailsState {}

class DetailsInitial extends DetailsState {}

class DetailsLoading extends DetailsState {}

class DetailsLoaded extends DetailsState {
  final dynamic details;

  final List<CastModel> casts;

  final List<MovieModel> recommendations;

  final List<EpisodeModel> episodes;

  final List<VideoModel> videos;

  final int selectedSeason;

  final bool isLoadingEpisodes;

  DetailsLoaded({
    required this.details,
    required this.casts,
    required this.recommendations,
    required this.episodes,
    required this.videos,
    required this.selectedSeason,
    this.isLoadingEpisodes = false,
  });

  DetailsLoaded copyWith({
    dynamic details,
    List<CastModel>? casts,
    List<MovieModel>? recommendations,
    List<EpisodeModel>? episodes,
    List<VideoModel>? videos,
    int? selectedSeason,
    bool? isLoadingEpisodes,
  }) {
    return DetailsLoaded(
      details: details ?? this.details,
      casts: casts ?? this.casts,
      recommendations: recommendations ?? this.recommendations,
      episodes: episodes ?? this.episodes,
      videos: videos ?? this.videos,
      selectedSeason: selectedSeason ?? this.selectedSeason,
      isLoadingEpisodes:
          isLoadingEpisodes ?? this.isLoadingEpisodes,
    );
  }
}

class DetailsError extends DetailsState {
  final String message;

  DetailsError(this.message);
}