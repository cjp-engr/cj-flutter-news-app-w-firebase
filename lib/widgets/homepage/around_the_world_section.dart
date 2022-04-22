import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_with_firebase/blocs/active_category/active_category_bloc.dart';
import 'package:news_app_with_firebase/constants/constants.dart';
import 'package:news_app_with_firebase/models/news.dart';
import 'package:animations/animations.dart';
import 'package:news_app_with_firebase/utils/string_extension.dart';
import 'package:news_app_with_firebase/widgets/homepage/article_section.dart';

class AroundTheWorldSection extends StatelessWidget {
  const AroundTheWorldSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsList =
        context.watch<ActiveCategoryBloc>().state.aroundTheWorldnewsList;
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
                    index: index,
                  );
                },
                closedBuilder: (BuildContext _, VoidCallback openContainer) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
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
            title!.trim(),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText2!.merge(
                  TextStyle(
                    color: themeLightColor1,
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
              color: themeLightColor4,
              border: Border.all(color: themeLightColor1),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                country!.trim().toTitleCase(),
                style: Theme.of(context).textTheme.caption!.merge(
                      TextStyle(
                        color: themeLightColor1,
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
