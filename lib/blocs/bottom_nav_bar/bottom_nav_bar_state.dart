part of 'bottom_nav_bar_bloc.dart';

class BottomNavBarState extends Equatable {
  final int currentIndex;
  const BottomNavBarState({
    required this.currentIndex,
  });

  factory BottomNavBarState.initial() {
    return const BottomNavBarState(
      currentIndex: 2,
    );
  }

  @override
  List<Object?> get props => [currentIndex];

  @override
  String toString() => 'BottomNavBarState(currentIndex: $currentIndex)';

  BottomNavBarState copyWith({
    int? currentIndex,
  }) {
    return BottomNavBarState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
