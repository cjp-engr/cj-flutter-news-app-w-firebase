part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final bool isThemeLightSwitch;
  const ThemeState({
    required this.isThemeLightSwitch,
  });

  factory ThemeState.initial() {
    return const ThemeState(isThemeLightSwitch: true);
  }
  @override
  List<Object?> get props => [isThemeLightSwitch];

  @override
  String toString() => 'ThemeState(isThemeLightSwitch: $isThemeLightSwitch)';

  ThemeState copyWith({
    bool? isThemeLightSwitch,
  }) {
    return ThemeState(
      isThemeLightSwitch: isThemeLightSwitch ?? this.isThemeLightSwitch,
    );
  }
}
