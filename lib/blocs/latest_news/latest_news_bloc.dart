import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:news_app_with_firebase/models/custom_error.dart';
import 'package:news_app_with_firebase/models/news.dart';
import 'package:news_app_with_firebase/repositories/news_repository.dart';

part 'latest_news_event.dart';
part 'latest_news_state.dart';

class LatestNewsBloc extends Bloc<LatestNewsEvent, LatestNewsState> {
  final NewsRepository newsRepository;
  LatestNewsBloc({
    required this.newsRepository,
  }) : super(LatestNewsState.initial()) {
    on<FetchLatestNewsEvent>(_fetchLatestNews);
  }

  FutureOr<void> _fetchLatestNews(
    LatestNewsEvent event,
    Emitter<LatestNewsState> emit,
  ) async {
    emit(state.copyWith(status: LatestNewsStatus.loading));

    try {
      final List<News>? newsList = await newsRepository.fetchNewsList();
      emit(state.copyWith(status: LatestNewsStatus.loaded, newsList: newsList));
    } on CustomError catch (e) {
      emit(state.copyWith(status: LatestNewsStatus.error, customError: e));
    }
  }
}
