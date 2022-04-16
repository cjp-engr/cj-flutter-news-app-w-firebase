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
        child: ListView.separated(
          itemCount: newsList.length,
          itemBuilder: (BuildContext context, int index) {
            var nList = newsList.elementAt(index);
            return Card(
              child: Column(
                children: [
                  Stack(
                    children: [
                      _image(context, nList.imageUrl),
                      _title(context, nList.title),
                      _country(context, nList.countries!),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        child: _creators(nList.creators!),
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
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              color: Colors.white,
              height: 10,
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
      bottom: 0,
      left: 0,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.1,
          child: Text(
            title!.trim(),
            style: Theme.of(context).textTheme.bodyText2!.merge(
                  const TextStyle(
                    color: Colors.white,
                  ),
                ),
            softWrap: true,
          ),
        ),
      ),
    );
  }

  Widget _country(BuildContext context, String country) {
    return Positioned(
      child: Align(
        alignment: FractionalOffset.topRight,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            country.trim(),
            style: Theme.of(context).textTheme.caption!.merge(
                  const TextStyle(
                    color: Colors.white,
                  ),
                ),
          ),
        ),
      ),
    );
  }

  Widget _creators(List<dynamic> creators) {
    for (var creator in creators) {
      return Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 7, left: 10),
        child: Text(
          creator.toString().trim().replaceAll(',', '\n'),
          textAlign: TextAlign.left,
        ),
      );
    }
    return const Text('Jesus Christ');
  }

  Widget _publishedDate(String pubDate) {
    final pDate = DateFormat.yMMMd()
        .format(DateFormat('yyyy-MM-dd HH:MM:SS').parse(pubDate));
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 7, right: 10),
      child: Text(
        pDate.trim(),
        textAlign: TextAlign.right,
      ),
    );
  }
}
