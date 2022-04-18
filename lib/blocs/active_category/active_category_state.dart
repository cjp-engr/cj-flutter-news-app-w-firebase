part of 'active_category_bloc.dart';

enum NewsLoadingStatus {
  initial,
  loading,
  loaded,
  error,
}

class ActiveCategoryState extends Equatable {
  final NewsLoadingStatus loadingStatus;
  final Categories activeCategory;
  final List<News> allCategoriesnewsList;
  final List<News> businessCategoriesnewsList;
  final List<News> entertainmentCategoriesnewsList;
  final List<News> environmentCategoriesnewsList;

  final CustomError customError;
  const ActiveCategoryState({
    required this.loadingStatus,
    required this.activeCategory,
    required this.allCategoriesnewsList,
    required this.businessCategoriesnewsList,
    required this.entertainmentCategoriesnewsList,
    required this.environmentCategoriesnewsList,
    required this.customError,
  });

  factory ActiveCategoryState.initial() {
    return const ActiveCategoryState(
      loadingStatus: NewsLoadingStatus.loading,
      activeCategory: Categories.all,
      allCategoriesnewsList: [],
      businessCategoriesnewsList: [],
      entertainmentCategoriesnewsList: [],
      environmentCategoriesnewsList: [],
      customError: CustomError(),
    );
  }

  @override
  List<Object?> get props => [
        loadingStatus,
        activeCategory,
        allCategoriesnewsList,
        businessCategoriesnewsList,
        entertainmentCategoriesnewsList,
        environmentCategoriesnewsList,
        customError,
      ];

  @override
  String toString() {
    return 'ActiveCategoryState(loadingStatus: $loadingStatus, activeCategory: $activeCategory, allCategoriesnewsList: $allCategoriesnewsList, businessCategoriesnewsList: $businessCategoriesnewsList, entertainmentCategoriesnewsList: $entertainmentCategoriesnewsList, environmentCategoriesnewsList: $environmentCategoriesnewsList, customError: $customError)';
  }

  ActiveCategoryState copyWith({
    NewsLoadingStatus? loadingStatus,
    Categories? activeCategory,
    List<News>? allCategoriesnewsList,
    List<News>? businessCategoriesnewsList,
    List<News>? entertainmentCategoriesnewsList,
    List<News>? environmentCategoriesnewsList,
    CustomError? customError,
  }) {
    return ActiveCategoryState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      activeCategory: activeCategory ?? this.activeCategory,
      allCategoriesnewsList:
          allCategoriesnewsList ?? this.allCategoriesnewsList,
      businessCategoriesnewsList:
          businessCategoriesnewsList ?? this.businessCategoriesnewsList,
      entertainmentCategoriesnewsList: entertainmentCategoriesnewsList ??
          this.entertainmentCategoriesnewsList,
      environmentCategoriesnewsList:
          environmentCategoriesnewsList ?? this.environmentCategoriesnewsList,
      customError: customError ?? this.customError,
    );
  }
}
