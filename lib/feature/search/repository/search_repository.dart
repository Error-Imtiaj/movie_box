import 'package:dio/dio.dart';
import 'package:movie_box/feature/home/model/movie_model.dart';

class SearchRepository {
  final Dio _dio;

  SearchRepository(this._dio);

  Future<List<MovieModel>> searchMovie(String query) async {
    final response = await _dio.get(
      '/search/movie',
      queryParameters: {
        'query': query,
        'include_adult': false,
        'page': 1,
      },
    );

    final List results = response.data['results'] ?? [];

    return results
        .map((json) => MovieModel.fromJson(json))
        .toList();
  }

  Future<List<MovieModel>> searchTv(String query) async {
    final response = await _dio.get(
      '/search/tv',
      queryParameters: {
        'query': query,
        'include_adult': false,
        'page': 1,
      },
    );

    final List results = response.data['results'] ?? [];

    return results
        .map((json) => MovieModel.fromJson(json))
        .toList();
  }

  Future<List<MovieModel>> multiSearch(String query) async {
    final response = await _dio.get(
      '/search/multi',
      queryParameters: {
        'query': query,
        'include_adult': false,
        'page': 1,
      },
    );

    final List results = response.data['results'] ?? [];

    return results
        .where((item) => item['media_type'] == 'movie' || item['media_type'] == 'tv')
        .map((json) => MovieModel.fromJson(json))
        .toList();
  }
}