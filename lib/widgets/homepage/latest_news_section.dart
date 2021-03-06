import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/blocs.dart';
import 'package:news_app_with_firebase/constants/constants.dart';
import 'package:news_app_with_firebase/models/news.dart';
import 'package:animations/animations.dart';
import 'package:news_app_with_firebase/widgets/homepage/article_section.dart';
import 'package:news_app_with_firebase/utils/string_extension.dart';

class LatestNewsSection extends StatelessWidget {
  const LatestNewsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsList =
        context.watch<ActiveCategoryBloc>().state.allCategoriesnewsList;

    return _latestNews(context, newsList);
  }

  Widget _latestNews(BuildContext context, List<News>? newsList) {
    const ContainerTransitionType _transitionType =
        ContainerTransitionType.fadeThrough;
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 3.5,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: newsList!.length,
          itemBuilder: (BuildContext ctx, index) {
            var nList = newsList.elementAt(index);
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: OpenContainer<bool>(
                transitionType: _transitionType,
                openBuilder: (BuildContext _, VoidCallback openContainer) {
                  return ArticleSection(
                    news: nList,
                    index: index,
                  );
                },
                closedBuilder: (BuildContext _, VoidCallback openContainer) {
                  return Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Stack(
                          children: [
                            _image(context, nList.imageUrl),
                            _title(context, nList.title),
                            _category(context, nList.categories),
                            _creators(context, nList.creators),
                          ],
                        ),
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
        alignment: FractionalOffset.topRight,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            title!.trim(),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle2!.merge(
                  TextStyle(
                    color: themeLightColor1,
                  ),
                ),
          ),
        ),
      ),
    );
  }

  Widget _category(BuildContext context, String? category) {
    return Positioned(
      child: Align(
        alignment: FractionalOffset.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            decoration: BoxDecoration(
              color: themeLightColor4,
              border: Border.all(color: themeLightColor1),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(5),
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                category!.trim().toTitleCase(),
                style: Theme.of(context).textTheme.bodyText2!.merge(
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

  Widget _creators(BuildContext context, List<dynamic>? authors) {
    for (var creator in authors!) {
      String auth = creator.toString().trim().replaceAll(',', '\n');
      return Positioned(
        child: Align(
          alignment: FractionalOffset.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              decoration: BoxDecoration(
                color: themeLightColor4,
                border: Border.all(color: themeLightColor1),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(5),
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  authors[0].toString().trim().contains(',')
                      ? auth
                      : auth.trim().length < 15
                          ? auth
                          : auth.substring(0, auth.indexOf(' ') + 2) + '.',
                  style: Theme.of(context).textTheme.bodyText2!.merge(
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
    return const Text('my test');
  }
}
