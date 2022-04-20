import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app_with_firebase/blocs/active_category/active_category_bloc.dart';
import 'package:news_app_with_firebase/models/news.dart';
import 'package:news_app_with_firebase/utils/list_of_categories.dart';

part 'saved_news_event.dart';
part 'saved_news_state.dart';

class SavedNewsBloc extends Bloc<SavedNewsEvent, SavedNewsState> {
  late StreamSubscription activeCategorySubscription;

  final ActiveCategoryBloc activeCategoryBloc;
  SavedNewsBloc({
    required this.activeCategoryBloc,
  }) : super(SavedNewsState.initial()) {
    activeCategorySubscription = activeCategoryBloc.stream
        .listen((ActiveCategoryState activeCategoryState) {
      addSavedAllCategoriesNews();
    });
    on<GetSavedNewsEvent>((event, emit) {
      emit(state.copyWith(newsSaved: event.savedNewsList));
    });
    on<ToggleSavedNewsEvent>(_toggleSavedNews);
  }

  void _toggleSavedNews(
      ToggleSavedNewsEvent event, Emitter<SavedNewsState> emit) {
    final togNews = state.newsSaved.map(
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

    emit(state.copyWith(newsSaved: togNews));
  }

  void addSavedAllCategoriesNews() {
    var _savedNews = <News>[];
    List<News> _savedAllNewsList = [];

    switch (activeCategoryBloc.state.activeCategory) {
      case Categories.all:
        _savedAllNewsList = activeCategoryBloc.state.allCategoriesnewsList
            .where((News news) => news.isSaved!)
            .toList();
        _savedNews = {
          ...state.newsSaved,
          ..._savedAllNewsList,
        }.toList();
        break;
      case Categories.business:
        _savedAllNewsList = activeCategoryBloc.state.businessCategoriesnewsList
            .where((News news) => news.isSaved!)
            .toList();
        _savedNews = {
          ...state.newsSaved,
          ..._savedAllNewsList,
        }.toList();
        break;
      case Categories.entertainment:
        _savedAllNewsList = activeCategoryBloc
            .state.entertainmentCategoriesnewsList
            .where((News news) => news.isSaved!)
            .toList();
        _savedNews = {
          ...state.newsSaved,
          ..._savedAllNewsList,
        }.toList();
        break;
      case Categories.environment:
        _savedAllNewsList = activeCategoryBloc
            .state.environmentCategoriesnewsList
            .where((News news) => news.isSaved!)
            .toList();
        _savedNews = {
          ...state.newsSaved,
          ..._savedAllNewsList,
        }.toList();
        break;
    }

    add(GetSavedNewsEvent(savedNewsList: _savedNews));
  }

  @override
  Future<void> close() {
    activeCategorySubscription.cancel();
    return super.close();
  }
}
