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
          activeCategory: ListOfCategories.all,
          newsList: newsList,
          loadingStatus: NewsLoadingStatus.loaded,
        ));
      } else if (ListOfCategories.business == event.activeCategory) {
        final List<News>? newsList = await newsRepository.fetchNewsByCategory(
            ListOfCategories.business.category.toLowerCase());
        emit(state.copyWith(
          activeCategory: ListOfCategories.business,
          newsList: newsList,
          loadingStatus: NewsLoadingStatus.loaded,
        ));
      } else if (ListOfCategories.entertainment == event.activeCategory) {
        final List<News>? newsList = await newsRepository.fetchNewsByCategory(
            ListOfCategories.entertainment.category.toLowerCase());
        emit(state.copyWith(
          activeCategory: ListOfCategories.entertainment,
          newsList: newsList,
          loadingStatus: NewsLoadingStatus.loaded,
        ));
      } else if (ListOfCategories.environment == event.activeCategory) {
        final List<News>? newsList = await newsRepository.fetchNewsByCategory(
            ListOfCategories.environment.category.toLowerCase());
        emit(state.copyWith(
          activeCategory: ListOfCategories.environment,
          newsList: newsList,
          loadingStatus: NewsLoadingStatus.loaded,
        ));
      } else if (ListOfCategories.food == event.activeCategory) {
        final List<News>? newsList = await newsRepository
            .fetchNewsByCategory(ListOfCategories.food.category.toLowerCase());
        emit(state.copyWith(
          activeCategory: ListOfCategories.food,
          newsList: newsList,
          loadingStatus: NewsLoadingStatus.loaded,
        ));
      } else if (ListOfCategories.health == event.activeCategory) {
        final List<News>? newsList = await newsRepository.fetchNewsByCategory(
            ListOfCategories.health.category.toLowerCase());
        emit(state.copyWith(
          activeCategory: ListOfCategories.health,
          newsList: newsList,
          loadingStatus: NewsLoadingStatus.loaded,
        ));
      } else if (ListOfCategories.politics == event.activeCategory) {
        final List<News>? newsList = await newsRepository.fetchNewsByCategory(
            ListOfCategories.politics.category.toLowerCase());
        emit(state.copyWith(
          activeCategory: ListOfCategories.politics,
          newsList: newsList,
          loadingStatus: NewsLoadingStatus.loaded,
        ));
      } else if (ListOfCategories.science == event.activeCategory) {
        final List<News>? newsList = await newsRepository.fetchNewsByCategory(
            ListOfCategories.science.category.toLowerCase());
        emit(state.copyWith(
          activeCategory: ListOfCategories.science,
          newsList: newsList,
          loadingStatus: NewsLoadingStatus.loaded,
        ));
      }
    } on CustomError catch (e) {
      emit(state.copyWith(
          loadingStatus: NewsLoadingStatus.error, customError: e));
    }
  }
}
