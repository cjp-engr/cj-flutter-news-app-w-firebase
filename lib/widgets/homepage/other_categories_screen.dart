import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: _creators(nList.creators!),
                      ),
                      Flexible(
                        child: _country(nList.countries!),
                      ),
                      Flexible(
                        child: _publishedDate(nList.publishedDate!),
                      ),
                    ],
                  ),
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
          return Image.network(
            'https://picsum.photos/300',
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

  Widget _publishedDate(String pubDate) {
    //final pDate = DateFormat('yyyy-MM-dd HH:MM:SS').parse(pubDate);
    final pDate = DateFormat.yMMMd()
        .format(DateFormat('yyyy-MM-dd HH:MM:SS').parse(pubDate));
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(pDate),
    );
  }

  Widget _country(String country) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(country),
    );
  }

  Widget _creators(List<dynamic> creators) {
    for (var creator in creators) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Text(creator),
      );
    }
    return const Text('Jesus Christ');
  }
}
