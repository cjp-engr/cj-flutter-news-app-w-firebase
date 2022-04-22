part of 'saved_news_bloc.dart';

enum SavedNewsStatus {
  initial,
  loading,
  loaded,
  error,
}

class SavedNewsState extends Equatable {
  final SavedNewsStatus newsStatus;
  final List<News> savedNews;
  final List<String> id;
  final CustomError error;
  const SavedNewsState({
    required this.newsStatus,
    required this.savedNews,
    required this.id,
    required this.error,
  });

  factory SavedNewsState.initial() {
    return const SavedNewsState(
      newsStatus: SavedNewsStatus.initial,
      savedNews: [],
      id: [],
      error: CustomError(),
    );
  }

  @override
  List<Object?> get props => [
        newsStatus,
        savedNews,
        id,
        error,
      ];

  @override
  String toString() {
    return 'SavedNewsState(newsStatus: $newsStatus, savedNews: $savedNews, id: $id, error: $error)';
  }

  SavedNewsState copyWith({
    SavedNewsStatus? newsStatus,
    List<News>? savedNews,
    List<String>? id,
    CustomError? error,
  }) {
    return SavedNewsState(
      newsStatus: newsStatus ?? this.newsStatus,
      savedNews: savedNews ?? this.savedNews,
      id: id ?? this.id,
      error: error ?? this.error,
    );
  }
}
