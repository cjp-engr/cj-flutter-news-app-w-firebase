import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.initial()) {
    on<SwitchThemeEvent>((event, emit) {
      emit(state.copyWith(isThemeLightSwitch: event.isSwitch));
    });
  }
}
