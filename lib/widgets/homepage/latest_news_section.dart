import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_with_firebase/blocs/active_category/active_category_bloc.dart';
import 'package:news_app_with_firebase/models/news.dart';

class LatestNewsSection extends StatelessWidget {
  const LatestNewsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsList = context.watch<ActiveCategoryBloc>().state.newsList;
    return _latestNews(context, newsList);
  }

  Widget _latestNews(BuildContext context, List<News>? newsList) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 3.5,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: newsList!.length,
          itemBuilder: (BuildContext ctx, index) {
            var nList = newsList.elementAt(index);
            return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: Stack(
                    children: [
                      _image(context, nList.imageUrl),
                      _title(context, nList.title),
                      _category(context, nList.categories),
                      _creators(context, nList.creators),
                    ],
                  ),
                ));
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
          // return const Text(
          //   'Oops!! An error occurred. 😢',
          //   style: TextStyle(fontSize: 16.0),
          // );
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

  Widget _title(BuildContext context, String? title) {
    return Positioned(
      child: Align(
        alignment: FractionalOffset.topRight,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            title!.trim().length < 80 ? title : title.substring(0, 80) + '...',
            style: Theme.of(context).textTheme.subtitle2!.merge(
                  const TextStyle(
                    color: Colors.white,
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
          padding: const EdgeInsets.all(10),
          child: Text(
            category!.trim(),
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

  Widget _creators(BuildContext context, List<dynamic>? authors) {
    for (var creator in authors!) {
      return Positioned(
        child: Align(
          alignment: FractionalOffset.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              creator.toString().trim().replaceAll(',', '\n'),
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
    return const Text('my test');
  }
}
