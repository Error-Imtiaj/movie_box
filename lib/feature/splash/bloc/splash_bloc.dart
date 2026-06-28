import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_box/core/services/local_storage/services/local_storage_service.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final LocalStorageService localStorage;

  SplashBloc(this.localStorage) : super(SplashInitial()) {
    on<SplashStarted>(_onSplashStarted);
  }

  Future<void> _onSplashStarted(
    SplashStarted event,

    Emitter<SplashState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 3));

    if (localStorage.isFirstTime) {
      emit(SplashNavigateToOnboarding());
    } else {
      emit(SplashNavigateToHome());
    }
  }
}
