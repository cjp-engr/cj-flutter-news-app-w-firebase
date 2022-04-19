part of 'saved_news_bloc.dart';

abstract class SavedNewsEvent extends Equatable {
  const SavedNewsEvent();

  @override
  List<Object> get props => [];
}

class GetSavedNewsEvent extends SavedNewsEvent {
  final List<News> savedNewsList;
  const GetSavedNewsEvent({
    required this.savedNewsList,
  });
}
