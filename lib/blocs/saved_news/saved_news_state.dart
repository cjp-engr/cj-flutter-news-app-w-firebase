part of 'saved_news_bloc.dart';

class SavedNewsState extends Equatable {
  final List<News> savedNews;
  final List<String> id;
  final bool isSaved;
  const SavedNewsState({
    required this.savedNews,
    required this.id,
    required this.isSaved,
  });

  factory SavedNewsState.initial() {
    return const SavedNewsState(
      savedNews: [],
      id: [],
      isSaved: false,
    );
  }

  @override
  List<Object?> get props => [
        savedNews,
        id,
        isSaved,
      ];

  @override
  String toString() =>
      'SavedNewsState(savedNews: $savedNews, id: $id, isSaved: $isSaved)';

  SavedNewsState copyWith({
    List<News>? savedNews,
    List<String>? id,
    bool? isSaved,
  }) {
    return SavedNewsState(
      savedNews: savedNews ?? this.savedNews,
      id: id ?? this.id,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}
