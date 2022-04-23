part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchInitialDetailsEvent extends ProfileEvent {
  final String uid;

  const FetchInitialDetailsEvent({
    required this.uid,
  });
}
