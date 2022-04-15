import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_with_firebase/blocs/active_category/active_category_bloc.dart';
import 'package:news_app_with_firebase/utils/list_of_categories.dart';
import 'package:news_app_with_firebase/widgets/homepage/all_category_screen.dart';
import 'package:news_app_with_firebase/widgets/homepage/categories/categories.dart';
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
              builder: (context, state) {
                if (state.activeCategory == Categories.all) {
                  return _allCategoryScreen();
                } else {
                  return _otherCategoriesScreen();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _allCategoryScreen() {
    return Expanded(
      child: ListView(
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text('Latest News'),
          ),
          LatestNewsScreen(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text('Around the world'),
          ),
          AroundTheWorldScreen(),
        ],
      ),
    );
  }

  Widget _otherCategoriesScreen() {
    return const OtherCategoriesScreen();
  }
}
