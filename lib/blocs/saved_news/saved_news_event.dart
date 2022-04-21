part of 'saved_news_bloc.dart';

abstract class SavedNewsEvent extends Equatable {
  const SavedNewsEvent();

  @override
  List<Object> get props => [];
}

class AddSavedNewsEvent extends SavedNewsEvent {
  final News savedNews;
  const AddSavedNewsEvent({
    required this.savedNews,
  });
}
