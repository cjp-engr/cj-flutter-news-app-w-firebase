import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:news_app_with_firebase/blocs/active_category/active_category_bloc.dart';
import 'package:news_app_with_firebase/models/news.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  late StreamSubscription activeCategorySubscription;

  final ActiveCategoryBloc activeCategoryBloc;
  CategoriesBloc({
    required this.activeCategoryBloc,
  }) : super(CategoriesState.initial()) {
    on<CategoriesEvent>((event, emit) {});
    activeCategorySubscription =
        activeCategoryBloc.stream.listen((ActiveCategoryState state) {});
  }
}
