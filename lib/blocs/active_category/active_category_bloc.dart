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
    on<ToggleSavedNewsEvent>(_toggleSavedNews);
  }

  void _toggleSavedNews(
    ToggleSavedNewsEvent event,
    Emitter<ActiveCategoryState> emit,
  ) {
    emit(state.copyWith(loadingStatus: NewsLoadingStatus.loading));
    final togNews = state.newsList.map(
      (News news) {
        if (event.id == news.id) {
          return News(
            title: news.title,
            creators: news.creators,
            description: news.description,
            content: news.content,
            publishedDate: news.publishedDate,
            imageUrl: news.imageUrl,
            countries: news.countries,
            categories: news.categories,
            fullDescription: news.fullDescription,
            id: news.id,
            isSaved: !news.isSaved!,
          );
        }
        return news;
      },
    ).toList();
    emit(state.copyWith(
      loadingStatus: NewsLoadingStatus.loaded,
      newsList: togNews,
    ));
  }

  FutureOr<void> _fetchLatestNews(
    FetchLatestNewsEvent event,
    Emitter<ActiveCategoryState> emit,
  ) async {
    try {
      if (state.newsList.isEmpty) {
        emit(state.copyWith(loadingStatus: NewsLoadingStatus.loading));
        final List<News>? newsList = await newsRepository.fetchNewsList();
        emit(state.copyWith(
            loadingStatus: NewsLoadingStatus.loaded, newsList: newsList));
      }
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
      if (Categories.all == event.activeCategory) {
        final List<News>? newsList = await newsRepository.fetchNewsList();
        emit(state.copyWith(
          activeCategory: Categories.all,
          newsList: newsList,
          loadingStatus: NewsLoadingStatus.loaded,
        ));
        if (state.newsList.isEmpty) {}
      } else if (Categories.business == event.activeCategory) {
        final List<News>? newsList =
            await newsRepository.fetchNewsByCategory(Categories.business.name);
        emit(state.copyWith(
          activeCategory: Categories.business,
          newsList: newsList,
          loadingStatus: NewsLoadingStatus.loaded,
        ));
      } else if (Categories.entertainment == event.activeCategory) {
        final List<News>? newsList = await newsRepository
            .fetchNewsByCategory(Categories.entertainment.name);
        emit(state.copyWith(
          activeCategory: Categories.entertainment,
          newsList: newsList,
          loadingStatus: NewsLoadingStatus.loaded,
        ));
      } else if (Categories.environment == event.activeCategory) {
        final List<News>? newsList = await newsRepository
            .fetchNewsByCategory(Categories.environment.name);
        emit(state.copyWith(
          activeCategory: Categories.environment,
          newsList: newsList,
          loadingStatus: NewsLoadingStatus.loaded,
        ));
      } else if (Categories.food == event.activeCategory) {
        final List<News>? newsList =
            await newsRepository.fetchNewsByCategory(Categories.food.name);
        emit(state.copyWith(
          activeCategory: Categories.food,
          newsList: newsList,
          loadingStatus: NewsLoadingStatus.loaded,
        ));
      } else if (Categories.health == event.activeCategory) {
        final List<News>? newsList =
            await newsRepository.fetchNewsByCategory(Categories.health.name);
        emit(state.copyWith(
          activeCategory: Categories.health,
          newsList: newsList,
          loadingStatus: NewsLoadingStatus.loaded,
        ));
      } else if (Categories.politics == event.activeCategory) {
        final List<News>? newsList =
            await newsRepository.fetchNewsByCategory(Categories.politics.name);
        emit(state.copyWith(
          activeCategory: Categories.politics,
          newsList: newsList,
          loadingStatus: NewsLoadingStatus.loaded,
        ));
      } else if (Categories.science == event.activeCategory) {
        final List<News>? newsList =
            await newsRepository.fetchNewsByCategory(Categories.science.name);
        emit(state.copyWith(
          activeCategory: Categories.science,
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
