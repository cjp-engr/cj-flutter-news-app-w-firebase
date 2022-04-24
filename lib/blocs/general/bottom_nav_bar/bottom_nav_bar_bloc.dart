import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app_with_firebase/blocs/blocs.dart';

part 'bottom_nav_bar_event.dart';
part 'bottom_nav_bar_state.dart';

class BottomNavBarBloc extends Bloc<BottomNavBarEvent, BottomNavBarState> {
  late StreamSubscription _signinSubscription;
  final SigninCubit signinCubit;
  BottomNavBarBloc({required this.signinCubit})
      : super(BottomNavBarState.initial()) {
    _signinSubscription = signinCubit.stream.listen((SigninState signinState) {
      if (signinState.signinStatus == SigninStatus.success) {
        add(const SetPageEvent(index: 2));
      }
    });
    on<SetPageEvent>((event, emit) {
      emit(state.copyWith(currentIndex: event.index));
    });
  }

  @override
  Future<void> close() {
    _signinSubscription.cancel();
    return super.close();
  }
}
