import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app_with_firebase/blocs/blocs.dart';

import 'package:news_app_with_firebase/models/news.dart';
import 'package:news_app_with_firebase/models/user_custom_error.dart';
import 'package:news_app_with_firebase/repositories/saved_news_repository.dart';

part 'saved_news_event.dart';
part 'saved_news_state.dart';

class SavedNewsBloc extends Bloc<SavedNewsEvent, SavedNewsState> {
  late StreamSubscription signinSubscription;
  final SigninCubit signinCubit;
  final SavedNewsRepository savedNewsRepository;
  SavedNewsBloc({
    required this.signinCubit,
    required this.savedNewsRepository,
  }) : super(SavedNewsState.initial()) {
    signinSubscription = signinCubit.stream.listen((SigninState signinState) {
      if (signinState.signinStatus == SigninStatus.success) {
        add(FetchSavedNewsEvent());
      }
    });
    on<ToggleSavedNewsEvent>(_toggleSavedNews);
    on<FetchSavedNewsEvent>(_initialLoadNews);
  }

  Future<void> _toggleSavedNews(
      ToggleSavedNewsEvent event, Emitter<SavedNewsState> emit) async {
    try {
      if (!state.id.contains(event.savedNews.id)) {
        final addedNews = News(
          title: event.savedNews.title,
          creators: event.savedNews.creators,
          description: event.savedNews.description,
          content: event.savedNews.content,
          publishedDate: event.savedNews.publishedDate,
          imageUrl: event.savedNews.imageUrl,
          countries: event.savedNews.countries,
          categories: event.savedNews.categories,
          fullDescription: event.savedNews.fullDescription,
          isSaved: true,
          id: event.savedNews.id,
        );
        await savedNewsRepository.saveNews(addedNews);
        List<String>? savedId = [...state.id, event.savedNews.id!];
        final savedNews = [...state.savedNews, addedNews];
        emit(
          state.copyWith(
            newsStatus: SavedNewsStatus.loaded,
            id: savedId,
            savedNews: savedNews,
          ),
        );
      } else {
        await savedNewsRepository.removeSavedNews(event.savedNews.id!);
        state.id.remove(event.savedNews.id);
        final savedNews = state.savedNews
            .where((News news) => news.id != event.savedNews.id)
            .toList();
        emit(
          state.copyWith(
            newsStatus: SavedNewsStatus.loaded,
            id: state.id,
            savedNews: savedNews,
          ),
        );
      }
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          newsStatus: SavedNewsStatus.error,
          error: e,
        ),
      );
    }
  }

  Future<void> _initialLoadNews(
    FetchSavedNewsEvent event,
    Emitter<SavedNewsState> emit,
  ) async {
    try {
      List<News> clearExistingTodos = [];
      List<String>? clearExistingIds = [];
      emit(state.copyWith(
        newsStatus: SavedNewsStatus.loading,
        savedNews: clearExistingTodos,
        id: clearExistingIds,
      ));
      var sNews = await savedNewsRepository.readSavedNews() as Map;
      for (var news in sNews.values) {
        final savedNews = News(
          title: news['title'],
          creators: news['creators'],
          description: news['description'],
          content: news['content'],
          publishedDate: news['publishedDate'],
          imageUrl: news['imageUrl'],
          countries: news['countries'],
          categories: news['categories'],
          fullDescription: news['fullDescription'],
          isSaved: news['isSaved'],
          id: news['id'],
        );
        List<String>? savedId = [...state.id, news['id']!];
        final rNews = [...state.savedNews, savedNews];
        emit(state.copyWith(
          savedNews: rNews,
          id: savedId,
          newsStatus: SavedNewsStatus.loaded,
        ));
      }
    } on CustomError catch (e) {
      emit(state.copyWith(
        newsStatus: SavedNewsStatus.error,
        error: e,
      ));
    }
  }

  @override
  Future<void> close() {
    signinSubscription.cancel();
    return super.close();
  }
}
