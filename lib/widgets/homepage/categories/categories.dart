import 'package:flutter/material.dart';
import 'package:news_app_with_firebase/utils/list_of_categories.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ElevatedButton(
            onPressed: () {},
            child: Text(ListOfCategories.all.category),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ElevatedButton(
            onPressed: () {},
            child: Text(ListOfCategories.business.category),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ElevatedButton(
            onPressed: () {},
            child: Text(ListOfCategories.entertainment.category),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ElevatedButton(
            onPressed: () {},
            child: Text(ListOfCategories.environment.category),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ElevatedButton(
            onPressed: () {},
            child: Text(ListOfCategories.food.category),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ElevatedButton(
            onPressed: () {},
            child: Text(ListOfCategories.health.category),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ElevatedButton(
            onPressed: () {},
            child: Text(ListOfCategories.politics.category),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ElevatedButton(
            onPressed: () {},
            child: Text(ListOfCategories.science.category),
          ),
        ),
      ],
    );
  }
}
