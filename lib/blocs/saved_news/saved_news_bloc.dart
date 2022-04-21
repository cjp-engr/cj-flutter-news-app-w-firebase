import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app_with_firebase/models/news.dart';

part 'saved_news_event.dart';
part 'saved_news_state.dart';

class SavedNewsBloc extends Bloc<SavedNewsEvent, SavedNewsState> {
  SavedNewsBloc() : super(SavedNewsState.initial()) {
    on<AddSavedNewsEvent>(_addSavedNews);
  }

  _addSavedNews(AddSavedNewsEvent event, Emitter<SavedNewsState> emit) {
    if (!state.id.contains(event.savedNews.id)) {
      final addedSavedNews = News(
        title: event.savedNews.title,
        creators: event.savedNews.creators,
        description: event.savedNews.description,
        content: event.savedNews.content,
        publishedDate: event.savedNews.publishedDate,
        imageUrl: event.savedNews.imageUrl,
        countries: event.savedNews.countries,
        categories: event.savedNews.categories,
        fullDescription: event.savedNews.fullDescription,
        isSaved: !event.savedNews.isSaved!,
        id: event.savedNews.id,
      );
      List<String>? savedId = [...state.id, event.savedNews.id!];
      final savedNews = [...state.savedNews, addedSavedNews];
      emit(state.copyWith(id: savedId, savedNews: savedNews));
    } else {
      state.id.remove(event.savedNews.id);
      final savedNews = state.savedNews
          .where((News news) => news.id != event.savedNews.id)
          .toList();

      emit(state.copyWith(id: state.id, savedNews: savedNews));
    }
  }
}
