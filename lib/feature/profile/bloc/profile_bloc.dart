import 'package:bloc/bloc.dart';
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
    emit(ProfileSaving(apiKey: event.apiKey));

    final isValid = await repository.validateApiKey(event.apiKey);

    if (!isValid) {
      emit(
        ProfileError(
          apiKey: event.apiKey,
          message: 'Invalid TMDB API Key.',
        ),
      );

      emit(ProfileLoaded(apiKey: event.apiKey));
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
