import 'package:dio/dio.dart';

class HomeRepository {
  final Dio dio;

  HomeRepository(this.dio);

  Future<bool> checkApiKey(String apiKey) async {
    try {
      final response = await dio.get(
        "/configuration",
        queryParameters: {"api_key": apiKey},
      );

      return response.statusCode == 200;
    } on DioException {
      return false;
    }
  }

  Future<Response> getTrendingMovies() {
    return dio.get("/trending/movie/day");
  }

  Future<Response> getPopularMovies() {
    return dio.get("/movie/popular");
  }

  Future<Response> getTopRatedMovies() {
    return dio.get("/movie/top_rated");
  }
}
