import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';


class AppBlocObserver extends BlocObserver {
  /// ANSI COLORS
  static const String reset = '\x1B[0m';

  static const String red = '\x1B[31m';
  static const String green = '\x1B[32m';
  static const String yellow = '\x1B[33m';
  static const String blue = '\x1B[34m';
  static const String purple = '\x1B[35m';
  static const String cyan = '\x1B[36m';
  static const String white = '\x1B[37m';

  /// EVENT
  @override
  void onEvent(Bloc bloc, Object? event) {
    log(
      '$cyan'
      '━━━━━━━━━━ EVENT ━━━━━━━━━━\n'
      'Bloc   : ${bloc.runtimeType}\n'
      'Event  : $event\n'
      '━━━━━━━━━━━━━━━━━━━━━━━━━━━'
      '$reset',
    );

    super.onEvent(bloc, event);
  }

  /// CHANGE (Cubit)
  @override
  void onChange(BlocBase bloc, Change change) {
    log(
      '$yellow'
      '━━━━━━━━━━ CHANGE ━━━━━━━━━━\n'
      'Cubit   : ${bloc.runtimeType}\n'
      'Current : ${change.currentState}\n'
      'Next    : ${change.nextState}\n'
      '━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
      '$reset',
    );

    super.onChange(bloc, change);
  }

  /// TRANSITION (Bloc)
  @override
  void onTransition(Bloc bloc, Transition transition) {
    log(
      '$green'
      '━━━━━━━━ TRANSITION ━━━━━━━━\n'
      'Bloc    : ${bloc.runtimeType}\n'
      'Event   : ${transition.event}\n'
      'Current : ${transition.currentState}\n'
      'Next    : ${transition.nextState}\n'
      '━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
      '$reset',
    );

    super.onTransition(bloc, transition);
  }

  /// ERROR
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log(
      '$red'
      '━━━━━━━━━━ ERROR ━━━━━━━━━━━\n'
      'Bloc   : ${bloc.runtimeType}\n'
      'Error  : $error\n'
      '━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
      '$reset',
    );

    super.onError(bloc, error, stackTrace);
  }

  /// CLOSE
  @override
  void onClose(BlocBase bloc) {
    log(
      '$purple'
      '━━━━━━━━━━ CLOSE ━━━━━━━━━━━\n'
      'Bloc/Cubit Closed : ${bloc.runtimeType}\n'
      '━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
      '$reset',
    );

    super.onClose(bloc);
  }

  /// CREATE
  @override
  void onCreate(BlocBase bloc) {
    log(
      '$blue'
      '━━━━━━━━━━ CREATE ━━━━━━━━━━\n'
      'Bloc/Cubit Created : ${bloc.runtimeType}\n'
      '━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
      '$reset',
    );

    super.onCreate(bloc);
  }
}