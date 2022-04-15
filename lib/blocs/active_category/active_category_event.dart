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
