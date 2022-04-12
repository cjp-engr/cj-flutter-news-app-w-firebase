import 'package:flutter/material.dart';
import 'package:news_app_with_firebase/utils/list_of_categories.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      "Business",
      "Enterntainment",
      "Environment",
      "Food",
      "Health",
      "Politics",
    ];
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
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(ListOfCategories.business.category),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(ListOfCategories.entertainment.category),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
