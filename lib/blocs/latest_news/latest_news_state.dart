part of 'latest_news_bloc.dart';

enum LatestNewsStatus {
  initial,
  loading,
  loaded,
  error,
}

class LatestNewsState extends Equatable {
  final LatestNewsStatus status;
  final List<News> newsList;
  final CustomError customError;
  const LatestNewsState({
    required this.status,
    required this.newsList,
    required this.customError,
  });

  factory LatestNewsState.initial() {
    return const LatestNewsState(
      status: LatestNewsStatus.initial,
      newsList: [],
      customError: CustomError(),
    );
  }

  @override
  List<Object?> get props => [status, newsList, customError];

  @override
  String toString() =>
      'LatestNewsState(status: $status, newsList: $newsList, customError: $customError)';

  LatestNewsState copyWith({
    LatestNewsStatus? status,
    List<News>? newsList,
    CustomError? customError,
  }) {
    return LatestNewsState(
      status: status ?? this.status,
      newsList: newsList ?? this.newsList,
      customError: customError ?? this.customError,
    );
  }
}
