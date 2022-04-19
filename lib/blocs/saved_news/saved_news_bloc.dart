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
      filterSavedAllCategoriesNews();
    });
    on<GetSavedNewsEvent>((event, emit) {
      emit(state.copyWith(newsSaved: event.savedNewsList));
    });
  }
  void filterSavedAllCategoriesNews() {
    var _savedNews = <News>[];
    List<News> _savedAllNewsList = [];
    List<News> _savedBusinessNewsList = [];
    List<News> _savedEntertainmentNewsList = [];
    List<News> _savedEnvironmentNewsList = [];

    switch (activeCategoryBloc.state.activeCategory) {
      case Categories.all:
        _savedAllNewsList = activeCategoryBloc.state.allCategoriesnewsList
            .where((News news) => news.isSaved! == true)
            .toList();
        break;
      case Categories.business:
        _savedBusinessNewsList = activeCategoryBloc
            .state.businessCategoriesnewsList
            .where((News news) => news.isSaved! == true)
            .toList();
        break;
      case Categories.entertainment:
        _savedEntertainmentNewsList = activeCategoryBloc
            .state.entertainmentCategoriesnewsList
            .where((News news) => news.isSaved! == true)
            .toList();
        break;
      case Categories.environment:
        _savedEnvironmentNewsList = activeCategoryBloc
            .state.environmentCategoriesnewsList
            .where((News news) => news.isSaved! == true)
            .toList();
        break;
    }
    _savedNews = {
      ..._savedAllNewsList,
      ..._savedBusinessNewsList,
      ..._savedEntertainmentNewsList,
      ..._savedEnvironmentNewsList,
    }.toList();

    add(GetSavedNewsEvent(savedNewsList: _savedNews));
  }

  @override
  Future<void> close() {
    activeCategorySubscription.cancel();
    return super.close();
  }
}
