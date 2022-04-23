import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/blocs.dart';
import 'package:news_app_with_firebase/constants/constants.dart';
import 'package:news_app_with_firebase/utils/list_of_categories.dart';
import 'package:news_app_with_firebase/utils/string_extension.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActiveCategoryBloc, ActiveCategoryState>(
      listener: (context, state) {
        const Text('May error');
      },
      builder: (context, state) {
        return ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: ElevatedButton(
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
                    Categories.all.name.toTitleCase(),
                    style: state.activeCategory == Categories.all
                        ? TextStyle(color: themeLightColor1)
                        : TextStyle(color: themeLightColor4),
                  ),
                )),
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: ElevatedButton(
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
                    Categories.business.name.toTitleCase(),
                    style: state.activeCategory == Categories.business
                        ? TextStyle(color: themeLightColor1)
                        : TextStyle(color: themeLightColor4),
                  ),
                )),
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: ElevatedButton(
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
                    Categories.entertainment.name.toTitleCase(),
                    style: state.activeCategory == Categories.entertainment
                        ? TextStyle(color: themeLightColor1)
                        : TextStyle(color: themeLightColor4),
                  ),
                )),
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: ElevatedButton(
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
                    Categories.environment.name.toTitleCase(),
                    style: state.activeCategory == Categories.environment
                        ? TextStyle(color: themeLightColor1)
                        : TextStyle(color: themeLightColor4),
                  ),
                )),
          ],
        );
      },
    );
  }
}
