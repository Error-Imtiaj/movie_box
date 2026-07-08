part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {
  final String apiKey;
  final bool loading;
  final bool saving;
  final bool success;
  final String? error;

  const ProfileState({
    this.apiKey = '',
    this.loading = false,
    this.saving = false,
    this.success = false,
    this.error,
  });
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial() : super(loading: true);
}

final class ProfileLoaded extends ProfileState {
  const ProfileLoaded({
    required super.apiKey,
  });
}

final class ProfileSaving extends ProfileState {
  const ProfileSaving({
    required super.apiKey,
  }) : super(
          saving: true,
        );
}

final class ProfileSuccess extends ProfileState {
  const ProfileSuccess({
    required super.apiKey,
  }) : super(
          success: true,
        );
}

final class ProfileError extends ProfileState {
  const ProfileError({
    required super.apiKey,
    required String message,
  }) : super(
          error: message,
        );
}