import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app_with_firebase/models/news.dart';
import 'package:news_app_with_firebase/models/user_custom_error.dart';
import 'package:news_app_with_firebase/repositories/news_repository.dart';

part 'search_news_event.dart';
part 'search_news_state.dart';

class SearchNewsBloc extends Bloc<SearchNewsEvent, SearchNewsState> {
  final NewsRepository newsRepository;
  SearchNewsBloc({
    required this.newsRepository,
  }) : super(SearchNewsState.initial()) {
    on<FetchSearchNewsEvent>(_fetchSearchNews);
  }
  Future<void> _fetchSearchNews(
      FetchSearchNewsEvent event, Emitter<SearchNewsState> emit) async {
    try {
      emit(state.copyWith(loadingStatus: SearchNewsLoadingStatus.loading));
      List<News>? newsResult =
          await newsRepository.fetchSearchNews(event.keyword);
      emit(state.copyWith(
        loadingStatus: SearchNewsLoadingStatus.loaded,
        newsResult: newsResult,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(
          loadingStatus: SearchNewsLoadingStatus.error, customError: e));
    }
  }
}
