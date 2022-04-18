part of 'active_category_bloc.dart';

abstract class ActiveCategoryEvent extends Equatable {
  const ActiveCategoryEvent();

  @override
  List<Object> get props => [];
}

class FetchNewsCategoryEvent extends ActiveCategoryEvent {
  final Categories activeCategory;
  const FetchNewsCategoryEvent({
    required this.activeCategory,
  });
}

class FetchLatestNewsEvent extends ActiveCategoryEvent {}

class ToggleAllCategorySavedNewsEvent extends ActiveCategoryEvent {
  final String id;

  const ToggleAllCategorySavedNewsEvent({
    required this.id,
  });
}

class ToggleBusinessCategorySavedNewsEvent extends ActiveCategoryEvent {
  final String id;

  const ToggleBusinessCategorySavedNewsEvent({
    required this.id,
  });
}

class ToggleEntertainmentCategorySavedNewsEvent extends ActiveCategoryEvent {
  final String id;

  const ToggleEntertainmentCategorySavedNewsEvent({
    required this.id,
  });
}

class ToggleEnvironmentCategorySavedNewsEvent extends ActiveCategoryEvent {
  final String id;

  const ToggleEnvironmentCategorySavedNewsEvent({
    required this.id,
  });
}
