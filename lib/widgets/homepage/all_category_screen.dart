import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_with_firebase/blocs/active_category/active_category_bloc.dart';
import 'package:news_app_with_firebase/models/news.dart';

class LatestNewsScreen extends StatelessWidget {
  const LatestNewsScreen({Key? key}) : super(key: key);

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
                      _title(nList.title)
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
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        errorBuilder: (
          BuildContext context,
          Object exception,
          StackTrace? stackTrace,
        ) {
          return const Text(
            'Oops!! An error occurred. 😢',
            style: TextStyle(fontSize: 16.0),
          );
        },
      ),
    );
  }

  Widget _title(String? title) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        title!,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}

class AroundTheWorldScreen extends StatelessWidget {
  const AroundTheWorldScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsList = context.watch<ActiveCategoryBloc>().state.newsList;
    return _aroundTheWorld(context, newsList);
  }

  Widget _aroundTheWorld(BuildContext context, List<News>? newsList) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 3,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: newsList!.length,
          itemBuilder: (BuildContext ctx, index) {
            var nList = newsList.elementAt(index);
            return SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 3,
                child: Card(
                  child: Stack(
                    children: [
                      _image(context, nList.imageUrl),
                      _title(nList.title)
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
        height: MediaQuery.of(context).size.height / 3,
        fit: BoxFit.cover,
        color: Colors.grey.withOpacity(1),
        colorBlendMode: BlendMode.modulate,
        loadingBuilder:
            (BuildContext ctx, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        errorBuilder: (
          BuildContext context,
          Object exception,
          StackTrace? stackTrace,
        ) {
          return const Text(
            'Oops!! An error occurred. 😢',
            style: TextStyle(fontSize: 16.0),
          );
        },
      ),
    );
  }

  Widget _title(String? title) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        title!,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}