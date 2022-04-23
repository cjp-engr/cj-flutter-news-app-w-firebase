part of 'search_news_bloc.dart';

abstract class SearchNewsEvent extends Equatable {
  const SearchNewsEvent();

  @override
  List<Object> get props => [];
}

class FetchSearchNewsEvent extends SearchNewsEvent {
  final String keyword;
  const FetchSearchNewsEvent({
    required this.keyword,
  });
}
