import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_box/feature/home/model/movie_response_model.dart';
import 'package:movie_box/feature/home/presentation/widgets/movie_category.dart';

class HomeRepository {
  final Dio dio;

  HomeRepository(this.dio);

  /// CHECK API KEY
  Future<bool> checkApiKey(String apiKey) async {
    debugPrint("run checkApiKey");
     debugPrint("HomeRepository received: '$apiKey'");
    try {
      final response = await dio.get(
        "/configuration",
        queryParameters: {"api_key": apiKey},
      );
      debugPrint(
        wrapWidth: 1000,
        'API Key Validation Response: ${response.data}',
      );
      debugPrint(
        wrapWidth: 1000,
        'API Key Validation Status Code: ${response.statusCode}',
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      debugPrint("Error occurred while validating API Key");
      debugPrint("Message: ${e.message}");
      debugPrint("Status Code: ${e.response?.statusCode}");
      debugPrint("Response: ${e.response?.data}");
      debugPrint("URI: ${e.requestOptions.uri}");

      return false;
    }
  }

  /// COMMON GET METHOD
  Future<MovieResponseModel> _getMovies(String endpoint, {int page = 1}) async {
    final response = await dio.get(endpoint, queryParameters: {"page": page});

    return MovieResponseModel.fromJson(response.data);
  }

  /// =========================
  /// MOVIES
  /// =========================

  Future<MovieResponseModel> getTrendingMovies({int page = 1}) =>
      _getMovies("/trending/movie/day", page: page);

  Future<MovieResponseModel> getPopularMovies({int page = 1}) =>
      _getMovies("/movie/popular", page: page);

  Future<MovieResponseModel> getTopRatedMovies({int page = 1}) =>
      _getMovies("/movie/top_rated", page: page);

  /// =========================
  /// TV SERIES
  /// =========================

  Future<MovieResponseModel> getTrendingTv({int page = 1}) =>
      _getMovies("/trending/tv/day", page: page);

  Future<MovieResponseModel> getPopularTv({int page = 1}) =>
      _getMovies("/tv/popular", page: page);

  Future<MovieResponseModel> getTopRatedTv({int page = 1}) =>
      _getMovies("/tv/top_rated", page: page);

  /// =========================
  /// TRENDING ALL (MOVIES + TV)
  /// =========================

  Future<MovieResponseModel> getTrendingAll({int page = 1}) =>
      _getMovies("/trending/all/day", page: page);

  Future<MovieResponseModel> getMovies(MovieCategory category, {int page = 1}) {
    switch (category) {
      case MovieCategory.trendingMovie:
        return getTrendingMovies(page: page);

      case MovieCategory.popularMovie:
        return getPopularMovies(page: page);

      case MovieCategory.topRatedMovie:
        return getTopRatedMovies(page: page);

      case MovieCategory.trendingTv:
        return getTrendingTv(page: page);

      case MovieCategory.popularTv:
        return getPopularTv(page: page);

      case MovieCategory.topRatedTv:
        return getTopRatedTv(page: page);

      case MovieCategory.trendingAll:
        return getTrendingAll(page: page);
    }
  }
}
