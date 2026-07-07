part of 'navigator_bloc.dart';

@immutable
sealed class NavigatorEvent {
  const NavigatorEvent();
}

final class ChangeNavigationIndex extends NavigatorEvent {
  final int index;

  const ChangeNavigationIndex(this.index);
}
