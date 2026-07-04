part of 'details_bloc.dart';

sealed class DetailsEvent {}

class LoadDetailsEvent extends DetailsEvent {

  final int id;

  final String mediaType;

  LoadDetailsEvent({

    required this.id,

    required this.mediaType,

  });

}

class ChangeSeasonEvent extends DetailsEvent {

  final int season;

  ChangeSeasonEvent(this.season);

}