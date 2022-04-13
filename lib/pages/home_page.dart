import 'package:flutter/material.dart';
import 'package:news_app_with_firebase/utils/list_of_categories.dart';
import 'package:news_app_with_firebase/widgets/carousel/around_the_world.dart';
import 'package:news_app_with_firebase/widgets/carousel/carousel_demo.dart';
import 'package:news_app_with_firebase/widgets/carousel/latest_news.dart';

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
            SizedBox(
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(ListOfCategories.all.category),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(ListOfCategories.business.category),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(ListOfCategories.entertainment.category),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(ListOfCategories.environment.category),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(ListOfCategories.food.category),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(ListOfCategories.health.category),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(ListOfCategories.politics.category),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(ListOfCategories.science.category),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
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
            ),
          ],
        ),
      ),
    );
  }
}
