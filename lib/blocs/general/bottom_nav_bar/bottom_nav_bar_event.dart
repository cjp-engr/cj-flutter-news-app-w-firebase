part of 'bottom_nav_bar_bloc.dart';

abstract class BottomNavBarEvent extends Equatable {
  const BottomNavBarEvent();

  @override
  List<Object> get props => [];
}

class SetPageEvent extends BottomNavBarEvent {
  final int index;
  const SetPageEvent({
    required this.index,
  });
}
