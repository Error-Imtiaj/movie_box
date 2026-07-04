part of 'details_bloc.dart';

sealed class DetailsEvent {
  const DetailsEvent();
}

class LoadDetailsEvent extends DetailsEvent {

  final int id;

  final String mediaType;

  const LoadDetailsEvent({
    required this.id,
    required this.mediaType,
  }) : super();

}

class ChangeSeasonEvent extends DetailsEvent {

  final int season;

  const ChangeSeasonEvent(this.season) : super();

}