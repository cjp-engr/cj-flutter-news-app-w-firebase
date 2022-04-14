import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app_with_firebase/models/custom_error.dart';
import 'package:news_app_with_firebase/models/news.dart';
import 'package:news_app_with_firebase/repositories/news_repository.dart';
import 'package:news_app_with_firebase/utils/list_of_categories.dart';

part 'active_category_event.dart';
part 'active_category_state.dart';

class ActiveCategoryBloc
    extends Bloc<ActiveCategoryEvent, ActiveCategoryState> {
  final NewsRepository newsRepository;
  ActiveCategoryBloc({
    required this.newsRepository,
  }) : super(ActiveCategoryState.initial()) {
    on<FetchLatestNewsEvent>(_fetchLatestNews);
    on<FetchNewsCategoryEvent>(_fetchNewsCategory);
  }

  FutureOr<void> _fetchLatestNews(
    FetchLatestNewsEvent event,
    Emitter<ActiveCategoryState> emit,
  ) async {
    emit(state.copyWith(loadingStatus: NewsLoadingStatus.loading));

    try {
      final List<News>? newsList = await newsRepository.fetchNewsList();
      emit(state.copyWith(
          loadingStatus: NewsLoadingStatus.loaded, newsList: newsList));
    } on CustomError catch (e) {
      emit(state.copyWith(
          loadingStatus: NewsLoadingStatus.error, customError: e));
    }
  }

  FutureOr<void> _fetchNewsCategory(
    FetchNewsCategoryEvent event,
    Emitter<ActiveCategoryState> emit,
  ) async {
    emit(state.copyWith(loadingStatus: NewsLoadingStatus.loading));
    try {
      if (ListOfCategories.all == event.activeCategory) {
        final List<News>? newsList = await newsRepository.fetchNewsList();
        emit(state.copyWith(
          newsList: newsList,
          loadingStatus: NewsLoadingStatus.loaded,
        ));
      } else if (ListOfCategories.business == event.activeCategory) {
        final List<News>? newsList = await newsRepository.fetchNewsByCategory(
            ListOfCategories.business.category.toLowerCase());
        emit(state.copyWith(
          newsList: newsList,
          loadingStatus: NewsLoadingStatus.loaded,
        ));
      } else {}
    } on CustomError catch (e) {
      emit(state.copyWith(
          loadingStatus: NewsLoadingStatus.error, customError: e));
    }
  }
}
