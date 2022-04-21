import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_with_firebase/blocs/active_category/active_category_bloc.dart';
import 'package:news_app_with_firebase/constants/constants.dart';
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
          child: BlocBuilder<ActiveCategoryBloc, ActiveCategoryState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  context.read<ActiveCategoryBloc>().add(
                        const FetchNewsCategoryEvent(
                            activeCategory: Categories.all),
                      );
                },
                style: state.activeCategory == Categories.all
                    ? ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(themeLightColor4),
                      )
                    : ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(themeLightColor1),
                      ),
                child: Text(
                  Categories.all.name,
                  style: state.activeCategory == Categories.all
                      ? TextStyle(color: themeLightColor1)
                      : TextStyle(color: themeLightColor4),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: BlocBuilder<ActiveCategoryBloc, ActiveCategoryState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  context.read<ActiveCategoryBloc>().add(
                        const FetchNewsCategoryEvent(
                            activeCategory: Categories.business),
                      );
                },
                style: state.activeCategory == Categories.business
                    ? ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(themeLightColor4),
                      )
                    : ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(themeLightColor1),
                      ),
                child: Text(
                  Categories.business.name,
                  style: state.activeCategory == Categories.business
                      ? TextStyle(color: themeLightColor1)
                      : TextStyle(color: themeLightColor4),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: BlocBuilder<ActiveCategoryBloc, ActiveCategoryState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  context.read<ActiveCategoryBloc>().add(
                        const FetchNewsCategoryEvent(
                            activeCategory: Categories.entertainment),
                      );
                },
                style: state.activeCategory == Categories.entertainment
                    ? ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(themeLightColor4),
                      )
                    : ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(themeLightColor1),
                      ),
                child: Text(
                  Categories.entertainment.name,
                  style: state.activeCategory == Categories.entertainment
                      ? TextStyle(color: themeLightColor1)
                      : TextStyle(color: themeLightColor4),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: BlocBuilder<ActiveCategoryBloc, ActiveCategoryState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  context.read<ActiveCategoryBloc>().add(
                        const FetchNewsCategoryEvent(
                            activeCategory: Categories.environment),
                      );
                },
                style: state.activeCategory == Categories.environment
                    ? ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(themeLightColor4),
                      )
                    : ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(themeLightColor1),
                      ),
                child: Text(
                  Categories.environment.name,
                  style: state.activeCategory == Categories.environment
                      ? TextStyle(color: themeLightColor1)
                      : TextStyle(color: themeLightColor4),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
