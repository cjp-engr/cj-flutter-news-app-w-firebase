import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_with_firebase/blocs/active_category/active_category_bloc.dart';
import 'package:news_app_with_firebase/utils/list_of_categories.dart';
import 'package:news_app_with_firebase/widgets/homepage/around_the_world_section.dart';
import 'package:news_app_with_firebase/widgets/homepage/categories/categories.dart';
import 'package:news_app_with_firebase/widgets/homepage/latest_news_section.dart';
import 'package:news_app_with_firebase/widgets/homepage/other_categories_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Welcome back, Carmen'),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 60,
              child: CategoriesList(),
            ),
            BlocBuilder<ActiveCategoryBloc, ActiveCategoryState>(
              builder: (_, state) {
                return state.activeCategory == Categories.all
                    ? _allCategoryScreen(context)
                    : state.loadingStatus == NewsLoadingStatus.loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : _otherCategoriesScreen();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _allCategoryScreen(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
            child: Text(
              'Latest News',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          const LatestNewsSection(),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
            child: Text(
              'Around the world',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          const AroundTheWorldSection(),
        ],
      ),
    );
  }

  Widget _otherCategoriesScreen() {
    return const OtherCategoriesScreen();
  }
}
