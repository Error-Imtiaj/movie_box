part of 'navigator_bloc.dart';

@immutable
sealed class AppNavigatorState {
  final int currentIndex;

  const AppNavigatorState(this.currentIndex);
}

final class NavigatorInitial extends AppNavigatorState {
  const NavigatorInitial() : super(0);
}

final class NavigatorChanged extends AppNavigatorState {
  const NavigatorChanged(int currentIndex) : super(currentIndex);
}
