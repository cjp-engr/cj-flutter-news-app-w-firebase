part of 'saved_news_bloc.dart';

class SavedNewsState extends Equatable {
  final List<News> newsSaved;

  const SavedNewsState({
    required this.newsSaved,
  });

  factory SavedNewsState.initial() {
    return const SavedNewsState(
      newsSaved: [],
    );
  }

  @override
  List<Object?> get props => [
        newsSaved,
      ];

  @override
  String toString() => 'SavedNewsState(newsSaved: $newsSaved, )';

  SavedNewsState copyWith({
    List<News>? newsSaved,
  }) {
    return SavedNewsState(
      newsSaved: newsSaved ?? this.newsSaved,
    );
  }
}
