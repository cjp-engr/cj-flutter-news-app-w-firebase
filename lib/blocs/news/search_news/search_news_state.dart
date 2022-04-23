part of 'search_news_bloc.dart';

enum SearchNewsLoadingStatus {
  initial,
  loading,
  loaded,
  error,
}

class SearchNewsState extends Equatable {
  final SearchNewsLoadingStatus loadingStatus;
  final List<News> newsResult;
  final CustomError customError;
  const SearchNewsState({
    required this.loadingStatus,
    required this.newsResult,
    required this.customError,
  });

  factory SearchNewsState.initial() {
    return const SearchNewsState(
      loadingStatus: SearchNewsLoadingStatus.initial,
      newsResult: [],
      customError: CustomError(),
    );
  }

  @override
  List<Object?> get props => [
        loadingStatus,
        newsResult,
        customError,
      ];

  @override
  String toString() =>
      'SearchNewsState(loadingStatus: $loadingStatus, newsResult: $newsResult, customError: $customError)';

  SearchNewsState copyWith({
    SearchNewsLoadingStatus? loadingStatus,
    List<News>? newsResult,
    CustomError? customError,
  }) {
    return SearchNewsState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      newsResult: newsResult ?? this.newsResult,
      customError: customError ?? this.customError,
    );
  }
}
