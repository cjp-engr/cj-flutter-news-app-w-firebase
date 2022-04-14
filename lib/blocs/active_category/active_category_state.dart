part of 'active_category_bloc.dart';

enum NewsLoadingStatus {
  initial,
  loading,
  loaded,
  error,
}

class ActiveCategoryState extends Equatable {
  final NewsLoadingStatus loadingStatus;
  final ListOfCategories activeCategory;
  final List<News> newsList;
  final CustomError customError;
  const ActiveCategoryState({
    required this.loadingStatus,
    required this.activeCategory,
    required this.newsList,
    required this.customError,
  });

  factory ActiveCategoryState.initial() {
    return const ActiveCategoryState(
      loadingStatus: NewsLoadingStatus.loading,
      activeCategory: ListOfCategories.all,
      newsList: [],
      customError: CustomError(),
    );
  }

  @override
  List<Object?> get props => [
        loadingStatus,
        activeCategory,
        newsList,
        customError,
      ];

  @override
  String toString() {
    return 'ActiveCategoryState(loadingStatus: $loadingStatus, activeCategory: $activeCategory, newsList: $newsList, customError: $customError)';
  }

  ActiveCategoryState copyWith({
    NewsLoadingStatus? loadingStatus,
    ListOfCategories? activeCategory,
    List<News>? newsList,
    CustomError? customError,
  }) {
    return ActiveCategoryState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      activeCategory: activeCategory ?? this.activeCategory,
      newsList: newsList ?? this.newsList,
      customError: customError ?? this.customError,
    );
  }
}
