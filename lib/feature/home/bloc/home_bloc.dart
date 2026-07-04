import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:movie_box/core/router/routes.dart';
import 'package:movie_box/core/services/local_storage/services/local_storage_service.dart';
import 'package:movie_box/feature/home/model/movie_response_model.dart';
import 'package:movie_box/feature/home/presentation/widgets/movie_category.dart';
import 'package:movie_box/feature/home/repository/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;
  final LocalStorageService localStorage;

  HomeBloc(this.repository, this.localStorage) : super(HomeInitial()) {
    on<SubmitApiKeyEvent>(_submitApiKey);
    on<LoadHomeEvent>(_loadHome);
  }

  // METHOD TO HANDLE API KEY SUBMISSION
  Future<void> _submitApiKey(
    SubmitApiKeyEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    final isValid = await repository.checkApiKey(event.apiKey);
    if (isValid) {
      await localStorage.setApiKey(event.apiKey);
      debugPrint('API Key set: ${event.apiKey}');
      emit(HomeApiValid());
    } else {
      emit(HomeApiInvalid("Invalid TMDB API Key"));
    }
  }

  // METHOD TO LOAD HOME DATA
  Future<void> _loadHome(LoadHomeEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

    try {
      final results = await Future.wait([
        repository.getTrendingMovies(),
        repository.getPopularMovies(),
        repository.getTopRatedMovies(),

        repository.getTrendingTv(),
        repository.getPopularTv(),
        repository.getTopRatedTv(),

        repository.getTrendingAll(),
      ]);

      emit(
        HomeLoaded(
          trendingMovies: results[0] as MovieResponseModel,
          popularMovies: results[1] as MovieResponseModel,
          topRatedMovies: results[2] as MovieResponseModel,
          trendingTv: results[3] as MovieResponseModel,
          popularTv: results[4] as MovieResponseModel,
          topRatedTv: results[5] as MovieResponseModel,
          trendingAll: results[6] as MovieResponseModel,
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
