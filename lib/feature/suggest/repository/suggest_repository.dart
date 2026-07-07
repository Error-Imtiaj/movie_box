import 'package:dio/dio.dart';
import 'package:movie_box/feature/home/model/movie_model.dart';

class SuggestRepository {
  final Dio _dioClient;

  SuggestRepository(this._dioClient);

  Future<List<MovieModel>> getSuggestions({
    required int page,
    String? mood,
    int? genreId,
  }) async {
    final response = await _dioClient.get(
      '/discover/movie',
      queryParameters: {
        'page': page,
        'sort_by': 'popularity.desc',
        'vote_count.gte': 100,
        'include_adult': false,
        if (genreId != null) 'with_genres': genreId,
        ..._moodParameters(mood),
      },
    );

    final results = (response.data['results'] as List?) ?? [];

    return results
        .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<MovieModel?> getRandomSuggestion() async {
    final response = await _dioClient.get(
      '/discover/movie',
      queryParameters: {
        'page': 1,
        'sort_by': 'popularity.desc',
        'vote_count.gte': 100,
        'include_adult': false,
      },
    );

    final results = (response.data['results'] as List?) ?? [];

    if (results.isEmpty) return null;

    results.shuffle();

    return MovieModel.fromJson(results.first as Map<String, dynamic>);
  }

  Map<String, dynamic> _moodParameters(String? mood) {
    switch (mood) {
      case 'Action':
        return {
          'with_genres': '28,12',
          'vote_average.gte': 7,
          'sort_by': 'popularity.desc',
        };

      case 'Comedy':
        return {'with_genres': '35', 'sort_by': 'vote_average.desc'};

      case 'Romance':
        return {'with_genres': '10749,18'};

      case 'Horror':
        return {'with_genres': '27,53'};

      case 'Sci-Fi':
        return {'with_genres': '878,12'};

      case 'Family':
        return {'with_genres': '10751,16'};

      default:
        return {};
    }
  }
}
