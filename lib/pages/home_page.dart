import 'package:flutter/material.dart';
import 'package:news_app_with_firebase/widgets/homepage/carousel/around_the_world.dart';
import 'package:news_app_with_firebase/widgets/homepage/carousel/latest_news.dart';
import 'package:news_app_with_firebase/widgets/homepage/categories/categories.dart';

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
            _allCategoryScreen(),
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

  // Widget _otherCategoriesScreen() {
  //   return Expanded(
  //     child: ListView.builder(
  //       itemBuilder: (context, position) {
  //         return Card(
  //           child: Padding(
  //             padding: const EdgeInsets.all(16.0),
  //             child: Text(
  //               position.toString(),
  //               style: const TextStyle(fontSize: 22.0),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
}
