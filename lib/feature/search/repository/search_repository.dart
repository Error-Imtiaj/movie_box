import 'package:dio/dio.dart';
import 'package:movie_box/feature/home/model/movie_model.dart';

class SearchRepository {
  final Dio _dio;

  SearchRepository(this._dio);

  Future<List<MovieModel>> searchMovie({
    required String query,
    int page = 1,
  }) async {
    final response = await _dio.get(
      '/search/movie',
      queryParameters: {
        'query': query,
        'include_adult': false,
        'page': page,
      },
    );

    final List results = response.data['results'] ?? [];

    return results
        .map((json) => MovieModel.fromJson(json))
        .toList();
  }

  Future<List<MovieModel>> searchTv({
    required String query,
    int page = 1,
  }) async {
    final response = await _dio.get(
      '/search/tv',
      queryParameters: {
        'query': query,
        'include_adult': false,
        'page': page,
      },
    );

    final List results = response.data['results'] ?? [];

    return results
        .map((json) => MovieModel.fromJson(json))
        .toList();
  }

  Future<List<MovieModel>> multiSearch({
    required String query,
    int page = 1,
  }) async {
    final response = await _dio.get(
      '/search/multi',
      queryParameters: {
        'query': query,
        'include_adult': false,
        'page': page,
      },
    );

    final List results = response.data['results'] ?? [];

    return results
        .where((item) => item['media_type'] == 'movie' || item['media_type'] == 'tv')
        .map((json) => MovieModel.fromJson(json))
        .toList();
  }
}