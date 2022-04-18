import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:news_app_with_firebase/blocs/active_category/active_category_bloc.dart';
import 'package:news_app_with_firebase/constants/constants.dart';
import 'package:news_app_with_firebase/models/news.dart';
import 'package:news_app_with_firebase/utils/list_of_categories.dart';

class ArticleSection extends StatelessWidget {
  final News news;
  final int index;
  const ArticleSection({
    Key? key,
    required this.news,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedCategory =
        context.watch<ActiveCategoryBloc>().state.activeCategory;

    return Scaffold(
      appBar: AppBar(
        title: Text(news.categories!),
        actions: [
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.font,
              size: 30,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: BlocBuilder<ActiveCategoryBloc, ActiveCategoryState>(
              builder: (context, state) {
                Icon iconBookMark(bool selectedCategory) {
                  if (selectedCategory) {
                    return const Icon(
                      Icons.bookmark,
                      size: 30,
                    );
                  } else {
                    return const Icon(
                      Icons.bookmark_border_outlined,
                      size: 30,
                    );
                  }
                }

                if (state.activeCategory == Categories.all) {
                  return iconBookMark(
                      state.allCategoriesnewsList[index].isSaved!);
                } else if (state.activeCategory == Categories.business) {
                  return iconBookMark(
                      state.businessCategoriesnewsList[index].isSaved!);
                } else if (state.activeCategory == Categories.entertainment) {
                  return iconBookMark(
                      state.entertainmentCategoriesnewsList[index].isSaved!);
                } else if (state.activeCategory == Categories.environment) {
                  return iconBookMark(
                      state.environmentCategoriesnewsList[index].isSaved!);
                } else {
                  return const Icon(
                    Icons.ac_unit_rounded,
                    size: 30,
                  );
                }
              },
            ),
            onPressed: () {
              if (selectedCategory == Categories.all) {
                context.read<ActiveCategoryBloc>().add(
                      ToggleAllCategorySavedNewsEvent(
                        id: news.id,
                      ),
                    );
              } else if (selectedCategory == Categories.business) {
                context.read<ActiveCategoryBloc>().add(
                      ToggleBusinessCategorySavedNewsEvent(
                        id: news.id,
                      ),
                    );
              } else if (selectedCategory == Categories.entertainment) {
                context.read<ActiveCategoryBloc>().add(
                      ToggleEntertainmentCategorySavedNewsEvent(
                        id: news.id,
                      ),
                    );
              } else if (selectedCategory == Categories.environment) {
                context.read<ActiveCategoryBloc>().add(
                      ToggleEnvironmentCategorySavedNewsEvent(
                        id: news.id,
                      ),
                    );
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            _title(context),
            _description(context),
            _image(context),
            _creator(context),
            _publishedDate(context),
            _content(context),
          ],
        ),
      ),
    );
  }

  Widget _title(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        news.title != null ? news.title! : loremIpsumParagraph.substring(0, 40),
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }

  Widget _description(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        news.description != null
            ? news.description!
            : loremIpsumParagraph.substring(0, 100),
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  Widget _image(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      child: Image.network(
        news.imageUrl!,
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 3.5,
        fit: BoxFit.cover,
        color: Colors.grey.withOpacity(1),
        colorBlendMode: BlendMode.modulate,
        loadingBuilder:
            (BuildContext ctx, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 3.5,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
            ),
          );
        },
        errorBuilder: (
          BuildContext context,
          Object exception,
          StackTrace? stackTrace,
        ) {
          return Image.asset(
            'assets/images/background-image.jpg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4.5,
            fit: BoxFit.cover,
            color: Colors.grey.withOpacity(1),
            colorBlendMode: BlendMode.modulate,
          );
        },
      ),
    );
  }

  Widget _creator(BuildContext context) {
    for (var creator in news.creators!) {
      String author = creator.toString().trim().replaceAll(',', ' and ');
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          'By: ' + author,
          style: Theme.of(context).textTheme.bodyText2!.merge(
                const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      );
    }
    return const Text('Jane Done');
  }

  Widget _publishedDate(BuildContext context) {
    final pDate =
        news.publishedDate!.substring(0, news.publishedDate!.indexOf(' ') + 1);
    final publishedDate =
        DateFormat.yMMMd().format(DateFormat('yyyy-MM-dd').parse(pDate));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        'Published: ' + publishedDate.trim(),
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        loremIpsumParagraph,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
