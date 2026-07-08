part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {
  const ProfileEvent();
}

final class LoadProfile extends ProfileEvent {
  const LoadProfile();
}

final class SaveApiKey extends ProfileEvent {
  final String apiKey;

  const SaveApiKey(this.apiKey);
}

final class ResetProfileState extends ProfileEvent {
  const ResetProfileState();
}
