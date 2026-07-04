import 'package:dio/dio.dart';
import 'package:movie_box/feature/details/model/cast_model.dart';
import 'package:movie_box/feature/details/model/episode_model.dart';
import 'package:movie_box/feature/details/model/movie_details_model.dart';
import 'package:movie_box/feature/details/model/tv_details_model.dart';
import 'package:movie_box/feature/details/model/video_model.dart';
import 'package:movie_box/feature/home/model/movie_model.dart';
import 'package:movie_box/feature/home/model/movie_response_model.dart';

class DetailsRepository {
  final Dio dio;

  DetailsRepository(this.dio);

  // ===========================
  // MOVIE
  // ===========================

  Future<MovieDetailsModel> getMovieDetails(int movieId) async {
    final response = await dio.get('/movie/$movieId');

    return MovieDetailsModel.fromJson(response.data);
  }

  Future<List<CastModel>> getMovieCast(int movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    return (response.data['cast'] as List)
        .map((e) => CastModel.fromJson(e))
        .toList();
  }

  Future<List<VideoModel>> getMovieVideos(int movieId) async {
    final response = await dio.get('/movie/$movieId/videos');

    return (response.data['results'] as List)
        .map((e) => VideoModel.fromJson(e))
        .toList();
  }

  Future<List<MovieModel>> getMovieRecommendations(int movieId) async {
    final response = await dio.get('/movie/$movieId/recommendations');

    return (response.data['results'] as List)
        .map((e) => MovieModel.fromJson(e))
        .toList();
  }

  // ===========================
  // TV
  // ===========================

  Future<TvDetailsModel> getTvDetails(int tvId) async {
    final response = await dio.get('/tv/$tvId');

    return TvDetailsModel.fromJson(response.data);
  }

  Future<List<CastModel>> getTvCast(int tvId) async {
    final response = await dio.get('/tv/$tvId/credits');

    return (response.data['cast'] as List)
        .map((e) => CastModel.fromJson(e))
        .toList();
  }

  Future<List<VideoModel>> getTvVideos(int tvId) async {
    final response = await dio.get('/tv/$tvId/videos');

    return (response.data['results'] as List)
        .map((e) => VideoModel.fromJson(e))
        .toList();
  }

  Future<List<MovieModel>> getTvRecommendations(int tvId) async {
    final response = await dio.get('/tv/$tvId/recommendations');

    return (response.data['results'] as List)
        .map((e) => MovieModel.fromJson(e))
        .toList();
  }

  // ===========================
  // TV SEASONS
  // ===========================

  Future<List<EpisodeModel>> getSeasonEpisodes({
    required int tvId,
    required int seasonNumber,
  }) async {
    final response = await dio.get('/tv/$tvId/season/$seasonNumber');

    return (response.data['episodes'] as List)
        .map((e) => EpisodeModel.fromJson(e))
        .toList();
  }
}
