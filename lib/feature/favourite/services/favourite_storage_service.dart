

import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_box/feature/home/model/movie_model.dart';

class FavouriteStorageService {
  static const String boxName = 'favourite_movies';

  Future<Box> get _box async => await Hive.openBox(boxName);

  Future<void> addMovie(MovieModel movie) async {
    final box = await _box;
    await box.put(movie.id, movie.toJson());
  }

  Future<void> removeMovie(int movieId) async {
    final box = await _box;
    await box.delete(movieId);
  }

  Future<bool> isFavourite(int movieId) async {
    final box = await _box;
    return box.containsKey(movieId);
  }

  Future<List<MovieModel>> getFavouriteMovies() async {
    final box = await _box;

    return box.values
        .map((e) => MovieModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> toggleFavourite(MovieModel movie) async {
    if (await isFavourite(movie.id)) {
      await removeMovie(movie.id);
    } else {
      await addMovie(movie);
    }
  }

  Future<void> clear() async {
    final box = await _box;
    await box.clear();
  }
}