import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blocs.dart';
import 'package:news_app_with_firebase/constants/constants.dart';
import 'package:news_app_with_firebase/utils/list_of_categories.dart';
import '../widgets/homepage/export_home_screen.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'News',
            style: TextStyle(color: themeLightColor1),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 80,
              child: CategoriesList(),
            ),
            BlocBuilder<ActiveCategoryBloc, ActiveCategoryState>(
              builder: (_, state) {
                return state.activeCategory == Categories.all
                    ? _allCategoryScreen(context)
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
      child: RefreshIndicator(
        onRefresh: () async {
          context
              .read<ActiveCategoryBloc>()
              .add(const RefreshNewsEvent(activeCategory: Categories.all));
        },
        color: themeLightColor2,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Text(
                'Latest News',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            const LatestNewsSection(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Text(
                'Around the world',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            const AroundTheWorldSection(),
          ],
        ),
      ),
    );
  }

  Widget _otherCategoriesScreen() {
    return const OtherCategoriesScreen();
  }
}
