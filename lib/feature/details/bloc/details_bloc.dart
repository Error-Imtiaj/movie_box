import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_box/feature/details/model/cast_model.dart';
import 'package:movie_box/feature/details/model/episode_model.dart';
import 'package:movie_box/feature/details/model/video_model.dart';
import 'package:movie_box/feature/details/repository/detail_repository.dart';
import 'package:movie_box/feature/home/model/movie_model.dart';
import 'package:movie_box/feature/home/model/movie_response_model.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final DetailsRepository repository;

  DetailsBloc(this.repository) : super(DetailsInitial()) {
    on<LoadDetailsEvent>(_loadDetails);
    on<ChangeSeasonEvent>(_changeSeason);
  }

  late int _id;
  late String _mediaType;

  Future<void> _loadDetails(
    LoadDetailsEvent event,
    Emitter<DetailsState> emit,
  ) async {
    emit(DetailsLoading());

    _id = event.id;
    _mediaType = event.mediaType;

    try {
      if (_mediaType == "movie") {
        final results = await Future.wait([
          repository.getMovieDetails(_id),
          repository.getMovieCast(_id),
          repository.getMovieRecommendations(_id),
          repository.getMovieVideos(_id),
        ]);

        emit(
          DetailsLoaded(
            details: results[0],
            casts: results[1] as List<CastModel>,
            recommendations: results[2] as List<MovieModel>,
            episodes: const [],
            videos: results[3] as List<VideoModel>,
            selectedSeason: 0,
            isLoadingEpisodes: false,
          ),
        );
      } else {
        final results = await Future.wait([
          repository.getTvDetails(_id),
          repository.getTvCast(_id),
          repository.getTvRecommendations(_id),
          repository.getSeasonEpisodes(tvId: _id, seasonNumber: 1),
          repository.getTvVideos(_id),
        ]);

        emit(
          DetailsLoaded(
            details: results[0],
            casts: results[1] as List<CastModel>,
            recommendations: results[2] as List<MovieModel>,
            episodes: results[3] as List<EpisodeModel>,
            videos: results[4] as List<VideoModel>,
            selectedSeason: 1,
            isLoadingEpisodes: false,
          ),
        );
      }
    } on SocketException {
      emit(DetailsError('No internet connection.'));
    } on DioException {
      emit(DetailsError('No internet connection.'));
    } catch (_) {
      emit(DetailsError('Something went wrong. Please try again.'));
    }
  }

  Future<void> _changeSeason(
    ChangeSeasonEvent event,
    Emitter<DetailsState> emit,
  ) async {
    if (state is! DetailsLoaded) return;

    final current = state as DetailsLoaded;

    if (current.selectedSeason == event.season) return;

    emit(
      current.copyWith(selectedSeason: event.season, isLoadingEpisodes: true),
    );

    try {
      final episodes = await repository.getSeasonEpisodes(
        tvId: _id,
        seasonNumber: event.season,
      );

      emit(
        current.copyWith(
          selectedSeason: event.season,
          episodes: episodes,
          isLoadingEpisodes: false,
        ),
      );
    } on SocketException {
      emit(current.copyWith(isLoadingEpisodes: false));
    } on DioException {
      emit(current.copyWith(isLoadingEpisodes: false));
    } catch (_) {
      emit(current.copyWith(isLoadingEpisodes: false));
    }
  }
}
