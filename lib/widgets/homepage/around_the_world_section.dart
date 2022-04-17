import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_with_firebase/blocs/active_category/active_category_bloc.dart';
import 'package:news_app_with_firebase/models/news.dart';
import 'package:animations/animations.dart';
import 'package:news_app_with_firebase/widgets/homepage/article_section.dart';

class AroundTheWorldSection extends StatelessWidget {
  const AroundTheWorldSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsList = context.watch<ActiveCategoryBloc>().state.newsList;
    return _aroundTheWorld(context, newsList);
  }

  Widget _aroundTheWorld(BuildContext context, List<News>? newsList) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity / 2,
        height: MediaQuery.of(context).size.height / 3,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: newsList!.length,
          itemBuilder: (BuildContext ctx, index) {
            var nList = newsList.elementAt(index);
            return SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 3,
              child: OpenContainer<bool>(
                openBuilder: (BuildContext _, VoidCallback openContainer) {
                  return ArticleSection(
                    news: nList,
                  );
                },
                closedBuilder: (BuildContext _, VoidCallback openContainer) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Card(
                      child: Stack(
                        children: [
                          _image(context, nList.imageUrl),
                          _title(context, nList.title),
                          _country(context, nList.countries),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _image(BuildContext context, String? imageUrl) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      child: Image.network(
        imageUrl!,
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 3,
        fit: BoxFit.cover,
        color: Colors.grey.withOpacity(1),
        colorBlendMode: BlendMode.modulate,
        loadingBuilder:
            (BuildContext ctx, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 3,
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
          // return const Text(
          //   'Oops!! An error occurred. 😢',
          //   style: TextStyle(fontSize: 16.0),
          // );
          return Image.network(
            'https://picsum.photos/300',
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 4.5,
            fit: BoxFit.cover,
            color: Colors.grey.withOpacity(1),
            colorBlendMode: BlendMode.modulate,
          );
        },
      ),
    );
  }

  Widget _title(BuildContext context, String? title) {
    return Positioned(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            title!.trim().length < 60
                ? title.trim()
                : title.trim().substring(0, 60) + '...',
            style: Theme.of(context).textTheme.bodyText2!.merge(
                  const TextStyle(
                    color: Colors.white,
                  ),
                ),
          ),
        ),
      ),
    );
  }

  Widget _country(BuildContext context, String? country) {
    return Positioned(
      child: Align(
        alignment: FractionalOffset.topRight,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                country!.trim(),
                style: Theme.of(context).textTheme.caption!.merge(
                      const TextStyle(
                        color: Colors.white,
                      ),
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
