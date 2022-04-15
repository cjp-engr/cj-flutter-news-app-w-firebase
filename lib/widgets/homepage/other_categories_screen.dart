import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_with_firebase/blocs/active_category/active_category_bloc.dart';

class OtherCategoriesScreen extends StatelessWidget {
  const OtherCategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsList = context.watch<ActiveCategoryBloc>().state.newsList;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView.builder(
          itemCount: newsList.length,
          itemBuilder: (BuildContext context, int index) {
            var nList = newsList.elementAt(index);
            return Card(
              child: Column(
                children: [
                  _image(context, nList.imageUrl),
                  _title(nList.title),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _image(BuildContext context, String? imageUrl) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Image.network(
        imageUrl!,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 4.5,
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
          color: Colors.black,
          fontSize: 15,
        ),
      ),
    );
  }
}
