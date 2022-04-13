part of 'latest_news_bloc.dart';

abstract class LatestNewsEvent extends Equatable {
  const LatestNewsEvent();

  @override
  List<Object> get props => [];
}

class FetchLatestNewsEvent extends LatestNewsEvent {}
