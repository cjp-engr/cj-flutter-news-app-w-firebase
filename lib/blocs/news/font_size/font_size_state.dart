part of 'font_size_bloc.dart';

class FontSizeState extends Equatable {
  final double fontSize;
  const FontSizeState({
    this.fontSize = 21,
  });

  factory FontSizeState.initial() {
    return const FontSizeState();
  }
  @override
  List<Object> get props => [fontSize];

  @override
  String toString() => 'FontSizeState(fontSize: $fontSize)';

  FontSizeState copyWith({
    double? fontSize,
  }) {
    return FontSizeState(
      fontSize: fontSize ?? this.fontSize,
    );
  }
}
