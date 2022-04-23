import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
//import 'package:news_app_with_firebase/blocs/auth/auth_bloc.dart';
import 'package:news_app_with_firebase/models/user_custom_error.dart';
import 'package:news_app_with_firebase/models/user_model.dart';
import 'package:news_app_with_firebase/repositories/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;

  ProfileBloc({
    required this.profileRepository,
  }) : super(ProfileState.initial()) {
    on<FetchInitialDetailsEvent>(_getProfile);
  }

  Future<void> _getProfile(
    FetchInitialDetailsEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(profileStatus: ProfileStatus.loading));

    try {
      final User user = await profileRepository.getProfile(uid: event.uid);
      emit(state.copyWith(
        profileStatus: ProfileStatus.loaded,
        user: user,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(
        profileStatus: ProfileStatus.error,
        error: e,
      ));
    }
  }
}
