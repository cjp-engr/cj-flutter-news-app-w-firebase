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
    on<ToggleAllCategorySavedNewsEvent>(_toggleAllCategorySavedNews);
    on<ToggleBusinessCategorySavedNewsEvent>(_toggleBusinessCategorySavedNews);
    on<ToggleEntertainmentCategorySavedNewsEvent>(
        _toggleEntertainmentCategorySavedNews);
    on<ToggleEnvironmentCategorySavedNewsEvent>(
        _toggleEnvironmentCategorySavedNews);
  }

  void _toggleAllCategorySavedNews(
    ToggleAllCategorySavedNewsEvent event,
    Emitter<ActiveCategoryState> emit,
  ) {
    emit(state.copyWith(loadingStatus: NewsLoadingStatus.loading));
    final togNews = state.allCategoriesnewsList.map(
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
      allCategoriesnewsList: togNews,
    ));
  }

  void _toggleBusinessCategorySavedNews(
    ToggleBusinessCategorySavedNewsEvent event,
    Emitter<ActiveCategoryState> emit,
  ) {
    emit(state.copyWith(loadingStatus: NewsLoadingStatus.loading));

    final togNews = state.businessCategoriesnewsList.map(
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
      businessCategoriesnewsList: togNews,
    ));
  }

  void _toggleEntertainmentCategorySavedNews(
    ToggleEntertainmentCategorySavedNewsEvent event,
    Emitter<ActiveCategoryState> emit,
  ) {
    emit(state.copyWith(loadingStatus: NewsLoadingStatus.loading));

    final togNews = state.entertainmentCategoriesnewsList.map(
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
      entertainmentCategoriesnewsList: togNews,
    ));
  }

  void _toggleEnvironmentCategorySavedNews(
    ToggleEnvironmentCategorySavedNewsEvent event,
    Emitter<ActiveCategoryState> emit,
  ) {
    emit(state.copyWith(loadingStatus: NewsLoadingStatus.loading));

    final togNews = state.environmentCategoriesnewsList.map(
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
      environmentCategoriesnewsList: togNews,
    ));
  }

  FutureOr<void> _fetchLatestNews(
    FetchLatestNewsEvent event,
    Emitter<ActiveCategoryState> emit,
  ) async {
    try {
      if (state.allCategoriesnewsList.isEmpty) {
        emit(state.copyWith(loadingStatus: NewsLoadingStatus.loading));
        final List<News>? newsList = await newsRepository.fetchNewsList();
        emit(state.copyWith(
            loadingStatus: NewsLoadingStatus.loaded,
            allCategoriesnewsList: newsList));
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
    try {
      if (Categories.all == event.activeCategory) {
        if (state.allCategoriesnewsList.isEmpty) {
          emit(state.copyWith(loadingStatus: NewsLoadingStatus.loading));
          final List<News>? newsList = await newsRepository.fetchNewsList();
          emit(state.copyWith(
            activeCategory: Categories.all,
            allCategoriesnewsList: newsList,
            loadingStatus: NewsLoadingStatus.loaded,
          ));
        } else {
          emit(state.copyWith(
            activeCategory: Categories.all,
            allCategoriesnewsList: state.allCategoriesnewsList,
            loadingStatus: NewsLoadingStatus.loaded,
          ));
        }
      } else if (Categories.business == event.activeCategory) {
        if (state.businessCategoriesnewsList.isEmpty) {
          final List<News>? newsList = await newsRepository
              .fetchNewsByCategory(Categories.business.name);
          emit(state.copyWith(
            activeCategory: Categories.business,
            businessCategoriesnewsList: newsList,
            loadingStatus: NewsLoadingStatus.loaded,
          ));
        } else {
          emit(state.copyWith(
            activeCategory: Categories.business,
            businessCategoriesnewsList: state.businessCategoriesnewsList,
            loadingStatus: NewsLoadingStatus.loaded,
          ));
        }
      } else if (Categories.entertainment == event.activeCategory) {
        if (state.entertainmentCategoriesnewsList.isEmpty) {
          final List<News>? newsList = await newsRepository
              .fetchNewsByCategory(Categories.entertainment.name);
          emit(state.copyWith(
            activeCategory: Categories.entertainment,
            entertainmentCategoriesnewsList: newsList,
            loadingStatus: NewsLoadingStatus.loaded,
          ));
        } else {
          emit(state.copyWith(
            activeCategory: Categories.entertainment,
            entertainmentCategoriesnewsList:
                state.entertainmentCategoriesnewsList,
            loadingStatus: NewsLoadingStatus.loaded,
          ));
        }
      } else if (Categories.environment == event.activeCategory) {
        if (state.environmentCategoriesnewsList.isEmpty) {
          final List<News>? newsList = await newsRepository
              .fetchNewsByCategory(Categories.environment.name);
          emit(state.copyWith(
            activeCategory: Categories.environment,
            environmentCategoriesnewsList: newsList,
            loadingStatus: NewsLoadingStatus.loaded,
          ));
        } else {
          emit(state.copyWith(
            activeCategory: Categories.environment,
            environmentCategoriesnewsList: state.environmentCategoriesnewsList,
            loadingStatus: NewsLoadingStatus.loaded,
          ));
        }
      }
    } on CustomError catch (e) {
      emit(state.copyWith(
          loadingStatus: NewsLoadingStatus.error, customError: e));
    }
  }
}
