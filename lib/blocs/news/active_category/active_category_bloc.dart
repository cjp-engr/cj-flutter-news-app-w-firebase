import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app_with_firebase/blocs/blocs.dart';
import 'package:news_app_with_firebase/models/user_custom_error.dart';
import 'package:news_app_with_firebase/models/news.dart';
import 'package:news_app_with_firebase/repositories/news_repository.dart';
import 'package:news_app_with_firebase/utils/list_of_categories.dart';

part 'active_category_event.dart';
part 'active_category_state.dart';

class ActiveCategoryBloc
    extends Bloc<ActiveCategoryEvent, ActiveCategoryState> {
  final NewsRepository newsRepository;
  late StreamSubscription signinSubscription;

  final SigninCubit signinCubit;

  ActiveCategoryBloc({
    required this.newsRepository,
    required this.signinCubit,
  }) : super(ActiveCategoryState.initial()) {
    signinSubscription = signinCubit.stream.listen((SigninState signinState) {
      if (signinState.signinStatus == SigninStatus.success) {
        add(FetchInitialNewsEvent());
      }
    });
    on<FetchInitialNewsEvent>(_fetchInitialNews);
    on<FetchNewsCategoryEvent>(_fetchNewsCategory);
    on<RefreshNewsEvent>(_refreshNews);
  }

  FutureOr<void> _fetchInitialNews(
    FetchInitialNewsEvent event,
    Emitter<ActiveCategoryState> emit,
  ) async {
    try {
      emit(state.copyWith(loadingStatus: NewsLoadingStatus.loading));
      final List<News>? latestList = await newsRepository.fetchNewsList();
      final List<News>? aroundList =
          await newsRepository.fetchAroundTheNewsList();
      emit(state.copyWith(
          loadingStatus: NewsLoadingStatus.loaded,
          allCategoriesnewsList: latestList,
          aroundTheWorldnewsList: aroundList));
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
          final List<News>? latestList = await newsRepository.fetchNewsList();
          final List<News>? aroundList =
              await newsRepository.fetchAroundTheNewsList();
          emit(state.copyWith(
            activeCategory: Categories.all,
            allCategoriesnewsList: latestList,
            aroundTheWorldnewsList: aroundList,
            loadingStatus: NewsLoadingStatus.loaded,
          ));
        } else {
          emit(state.copyWith(
            activeCategory: Categories.all,
            allCategoriesnewsList: state.allCategoriesnewsList,
            aroundTheWorldnewsList: state.aroundTheWorldnewsList,
            loadingStatus: NewsLoadingStatus.loaded,
          ));
        }
      } else if (Categories.business == event.activeCategory) {
        if (state.businessCategoriesnewsList.isEmpty) {
          emit(state.copyWith(loadingStatus: NewsLoadingStatus.loading));
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
          emit(state.copyWith(loadingStatus: NewsLoadingStatus.loading));
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
          emit(state.copyWith(loadingStatus: NewsLoadingStatus.loading));
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

  FutureOr<void> _refreshNews(
    RefreshNewsEvent event,
    Emitter<ActiveCategoryState> emit,
  ) async {
    try {
      if (Categories.all == event.activeCategory) {
        emit(state.copyWith(loadingStatus: NewsLoadingStatus.loading));
        final List<News>? latestList = await newsRepository.fetchNewsList();
        final List<News>? aroundList =
            await newsRepository.fetchAroundTheNewsList();
        emit(state.copyWith(
          activeCategory: Categories.all,
          allCategoriesnewsList: latestList,
          aroundTheWorldnewsList: aroundList,
          loadingStatus: NewsLoadingStatus.loaded,
        ));
      } else if (Categories.business == event.activeCategory) {
        emit(state.copyWith(loadingStatus: NewsLoadingStatus.loading));
        final List<News>? newsList =
            await newsRepository.fetchNewsByCategory(Categories.business.name);
        emit(state.copyWith(
          activeCategory: Categories.business,
          businessCategoriesnewsList: newsList,
          loadingStatus: NewsLoadingStatus.loaded,
        ));
      } else if (Categories.entertainment == event.activeCategory) {
        emit(state.copyWith(loadingStatus: NewsLoadingStatus.loading));
        final List<News>? newsList = await newsRepository
            .fetchNewsByCategory(Categories.entertainment.name);
        emit(state.copyWith(
          activeCategory: Categories.entertainment,
          entertainmentCategoriesnewsList: newsList,
          loadingStatus: NewsLoadingStatus.loaded,
        ));
      } else if (Categories.environment == event.activeCategory) {
        emit(state.copyWith(loadingStatus: NewsLoadingStatus.loading));
        final List<News>? newsList = await newsRepository
            .fetchNewsByCategory(Categories.environment.name);
        emit(state.copyWith(
          activeCategory: Categories.environment,
          environmentCategoriesnewsList: newsList,
          loadingStatus: NewsLoadingStatus.loaded,
        ));
      }
    } on CustomError catch (e) {
      emit(state.copyWith(
          loadingStatus: NewsLoadingStatus.error, customError: e));
    }
  }

  @override
  Future<void> close() {
    signinSubscription.cancel();
    return super.close();
  }
}
