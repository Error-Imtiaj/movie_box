part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

// CHECK API STATE
class HomeApiValid extends HomeState {}

class HomeApiInvalid extends HomeState {
  final String message;
  HomeApiInvalid(this.message);
}

class HomeLoaded extends HomeState {
  final MovieResponseModel trendingMovies;
  final MovieResponseModel popularMovies;
  final MovieResponseModel topRatedMovies;
  final MovieResponseModel trendingTv;
  final MovieResponseModel popularTv;
  final MovieResponseModel topRatedTv;
  final MovieResponseModel trendingAll; 

  HomeLoaded({
    required this.trendingMovies,
    required this.popularMovies,
    required this.topRatedMovies,
    required this.trendingTv,
    required this.popularTv,
    required this.topRatedTv, required this.trendingAll,
  });
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
