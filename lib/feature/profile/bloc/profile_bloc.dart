import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:movie_box/feature/profile/repository/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  ProfileBloc(this.repository) : super(const ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<SaveApiKey>(_onSaveApiKey);
    on<ResetProfileState>(_onResetProfileState);
  }

  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileInitial());

    final apiKey = await repository.getApiKey();

    emit(ProfileLoaded(apiKey: apiKey));
  }

  Future<void> _onSaveApiKey(
    SaveApiKey event,
    Emitter<ProfileState> emit,
  ) async {
    debugPrint(wrapWidth: 1000, 'Saving API Key: ${event.apiKey}');

    // Show loading while validating.
    emit(ProfileSaving(apiKey: state.apiKey));

    final previousApiKey = await repository.getApiKey();
    final isValid = await repository.validateApiKey(event.apiKey);

    debugPrint(
      wrapWidth: 1000,
      'API Key Validation Result: $isValid',
    );

    if (!isValid) {
      emit(
        ProfileError(
          apiKey: previousApiKey,
          message: 'Invalid TMDB API Key.',
        ),
      );

      emit(ProfileLoaded(apiKey: previousApiKey));
      return;
    }

    await repository.saveApiKey(event.apiKey);

    emit(ProfileSuccess(apiKey: event.apiKey));
    emit(ProfileLoaded(apiKey: event.apiKey));
  }

  void _onResetProfileState(
    ResetProfileState event,
    Emitter<ProfileState> emit,
  ) {
    emit(ProfileLoaded(apiKey: state.apiKey));
  }
}
