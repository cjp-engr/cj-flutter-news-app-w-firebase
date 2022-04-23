import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'font_size_event.dart';
part 'font_size_state.dart';

class FontSizeBloc extends Bloc<FontSizeEvent, FontSizeState> {
  FontSizeBloc() : super(FontSizeState.initial()) {
    on<ChangeFontSizeEvent>((event, emit) {
      emit(state.copyWith(fontSize: event.fontSize));
    });
  }
}
