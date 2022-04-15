import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_with_firebase/blocs/active_category/active_category_bloc.dart';
import 'package:news_app_with_firebase/utils/list_of_categories.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ElevatedButton(
            onPressed: () {
              context.read<ActiveCategoryBloc>().add(
                    const FetchNewsCategoryEvent(
                        activeCategory: Categories.all),
                  );
            },
            child: Text(Categories.all.name),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ElevatedButton(
            onPressed: () {
              context.read<ActiveCategoryBloc>().add(
                    const FetchNewsCategoryEvent(
                        activeCategory: Categories.business),
                  );
            },
            child: Text(Categories.business.name),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ElevatedButton(
            onPressed: () {
              context.read<ActiveCategoryBloc>().add(
                    const FetchNewsCategoryEvent(
                        activeCategory: Categories.entertainment),
                  );
            },
            child: Text(Categories.entertainment.name),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ElevatedButton(
            onPressed: () {
              context.read<ActiveCategoryBloc>().add(
                    const FetchNewsCategoryEvent(
                        activeCategory: Categories.environment),
                  );
            },
            child: Text(Categories.environment.name),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ElevatedButton(
            onPressed: () {
              context.read<ActiveCategoryBloc>().add(
                    const FetchNewsCategoryEvent(
                        activeCategory: Categories.food),
                  );
            },
            child: Text(Categories.food.name),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ElevatedButton(
            onPressed: () {
              context.read<ActiveCategoryBloc>().add(
                    const FetchNewsCategoryEvent(
                        activeCategory: Categories.health),
                  );
            },
            child: Text(Categories.health.name),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ElevatedButton(
            onPressed: () {
              context.read<ActiveCategoryBloc>().add(
                    const FetchNewsCategoryEvent(
                        activeCategory: Categories.politics),
                  );
            },
            child: Text(Categories.politics.name),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ElevatedButton(
            onPressed: () {
              context.read<ActiveCategoryBloc>().add(
                    const FetchNewsCategoryEvent(
                        activeCategory: Categories.science),
                  );
            },
            child: Text(Categories.science.name),
          ),
        ),
      ],
    );
  }
}
