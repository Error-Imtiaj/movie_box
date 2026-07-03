import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:movie_box/core/router/routes.dart';
import 'package:movie_box/core/services/local_storage/services/local_storage_service.dart';
import 'package:movie_box/feature/home/repository/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;
  final LocalStorageService localStorage;

  HomeBloc(this.repository, this.localStorage) : super(HomeInitial()) {
    on<SubmitApiKeyEvent>(_submitApiKey);
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
}
