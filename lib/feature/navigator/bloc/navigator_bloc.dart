import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigator_event.dart';
part 'navigator_state.dart';

class NavigatorBloc extends Bloc<NavigatorEvent, AppNavigatorState> {
  NavigatorBloc() : super(const NavigatorInitial()) {
    on<ChangeNavigationIndex>(_onChangeNavigationIndex);
  }

  void _onChangeNavigationIndex(
    ChangeNavigationIndex event,
    Emitter<AppNavigatorState> emit,
  ) {
    emit(NavigatorChanged(event.index));
  }
}
