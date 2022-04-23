part of 'font_size_bloc.dart';

abstract class FontSizeEvent extends Equatable {
  const FontSizeEvent();

  @override
  List<Object> get props => [];
}

class ChangeFontSizeEvent extends FontSizeEvent {
  final double fontSize;

  const ChangeFontSizeEvent({
    required this.fontSize,
  });
}
