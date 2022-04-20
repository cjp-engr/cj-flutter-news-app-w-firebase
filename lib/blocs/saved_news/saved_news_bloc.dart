import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app_with_firebase/models/news.dart';

part 'saved_news_event.dart';
part 'saved_news_state.dart';

class SavedNewsBloc extends Bloc<SavedNewsEvent, SavedNewsState> {
  SavedNewsBloc() : super(SavedNewsState.initial()) {
    on<AddSavedNewsEvent>(_addSavedNews);
    on<IsSavedNewsEvent>(_isSavedNews);
  }

  _isSavedNews(IsSavedNewsEvent event, Emitter<SavedNewsState> emit) {
    emit(state.copyWith(isSaved: event.isSaved));
    if (state.isSaved) {
      add(AddSavedNewsEvent(savedNews: event.savedNews));
      print('hi');
    } else {
      print(state.id);
    }
  }

  _addSavedNews(AddSavedNewsEvent event, Emitter<SavedNewsState> emit) {
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
    final savedNews = [...state.savedNews, addedSavedNews];
    List<String>? savedId = [...state.id, event.savedNews.id!];

    emit(state.copyWith(id: savedId, savedNews: savedNews));
  }
}
