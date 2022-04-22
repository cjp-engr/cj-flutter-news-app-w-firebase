import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_app_with_firebase/blocs/saved_news/saved_news_bloc.dart';
import 'package:news_app_with_firebase/widgets/homepage/article_section.dart';

class SavedNews extends StatelessWidget {
  const SavedNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final savedNewsList = context.watch<SavedNewsBloc>().state.savedNews;

    return Expanded(
      child: ListView.separated(
        itemCount: savedNewsList.length,
        itemBuilder: (BuildContext context, int index) {
          var nList = savedNewsList.elementAt(index);

          return OpenContainer<bool>(
            openBuilder: (_, VoidCallback openContainer) {
              return ArticleSection(
                news: nList,
                index: index,
              );
            },
            closedBuilder: (_, VoidCallback openContainer) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          _image(context, nList.imageUrl),
                          _title(context, nList.title),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            color: Colors.white,
            height: 5,
          );
        },
      ),
    );
  }

  Widget _image(BuildContext context, String? imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        imageUrl!,
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 5,
        fit: BoxFit.cover,
        color: Colors.grey.withOpacity(1),
        colorBlendMode: BlendMode.modulate,
        loadingBuilder:
            (BuildContext ctx, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 5,
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
      // bottom: 0,
      // left: 0,
      child: Align(
        alignment: FractionalOffset.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 1.1,
            child: Text(
              title!.trim(),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1!.merge(
                    const TextStyle(
                      color: Colors.white,
                    ),
                  ),
              softWrap: true,
            ),
          ),
        ),
      ),
    );
  }
}
