import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_with_firebase/blocs/active_category/active_category_bloc.dart';
import 'package:news_app_with_firebase/models/news.dart';
import 'package:news_app_with_firebase/utils/list_of_categories.dart';
import 'package:news_app_with_firebase/widgets/homepage/all_screen/around_the_world.dart';
import 'package:news_app_with_firebase/widgets/homepage/all_screen/latest_news.dart';
import 'package:news_app_with_firebase/widgets/homepage/categories/categories.dart';
import 'package:news_app_with_firebase/widgets/homepage/news_images.dart';
import 'package:news_app_with_firebase/widgets/homepage/news_title.dart';

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
              child: Categories(),
            ),
            BlocBuilder<ActiveCategoryBloc, ActiveCategoryState>(
              builder: (context, state) {
                if (state.activeCategory == ListOfCategories.all) {
                  return _allCategoryScreen();
                } else {
                  //Text(state.activeCategory.name);
                  return _otherCategoriesScreen(state.newsList);
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
          LatestNews(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text('Around the world'),
          ),
          AroundTheWorld(),
        ],
      ),
    );
  }

  Widget _otherCategoriesScreen(List<News> newsList) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView.builder(
            itemCount: newsList.length,
            itemBuilder: (BuildContext context, int index) {
              var nList = newsList.elementAt(index);
              return Card(
                child: Stack(
                  children: [
                    NewsImages.imageLarge(context, nList.imageUrl, 4),
                    NewsTitle.title(nList.title),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
