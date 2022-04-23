part of 'saved_news_bloc.dart';

abstract class SavedNewsEvent extends Equatable {
  const SavedNewsEvent();

  @override
  List<Object> get props => [];
}

class ToggleSavedNewsEvent extends SavedNewsEvent {
  final News savedNews;
  const ToggleSavedNewsEvent({
    required this.savedNews,
  });
}

class FetchSavedNewsEvent extends SavedNewsEvent {}
