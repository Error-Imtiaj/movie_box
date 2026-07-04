import 'movie_model.dart';

class MovieResponseModel {
  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalResults;

  MovieResponseModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieResponseModel.fromJson(Map<String, dynamic> json) {
    return MovieResponseModel(
      page: json["page"],
      totalPages: json["total_pages"],
      totalResults: json["total_results"],
      results: (json["results"] as List)
          .map((e) => MovieModel.fromJson(e))
          .toList(),
    );
  }
}