

import 'package:movie_box/feature/favourite/services/favourite_storage_service.dart';
import 'package:movie_box/feature/home/model/movie_model.dart';

class FavouriteRepository {
  FavouriteRepository(this._storageService);

  final FavouriteStorageService _storageService;

  Future<void> addToFavourite(MovieModel movie) {
    return _storageService.addMovie(movie);
  }

  Future<void> removeFromFavourite(int movieId) {
    return _storageService.removeMovie(movieId);
  }

  Future<void> toggleFavourite(MovieModel movie) {
    return _storageService.toggleFavourite(movie);
  }

  Future<bool> isFavourite(int movieId) {
    return _storageService.isFavourite(movieId);
  }

  Future<List<MovieModel>> getFavouriteMovies() {
    return _storageService.getFavouriteMovies();
  }

  Future<void> clearFavourites() {
    return _storageService.clear();
  }
}