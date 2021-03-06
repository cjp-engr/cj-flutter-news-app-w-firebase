import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';
import '../../blocs/blocs.dart';

import 'package:news_app_with_firebase/constants/constants.dart';
import 'package:news_app_with_firebase/models/news.dart';
import 'package:news_app_with_firebase/utils/string_extension.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          news.categories!.toTitleCase(),
          style: Theme.of(context).textTheme.headline6!.merge(
                TextStyle(color: themeLightColor1),
              ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 40,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: BlocBuilder<SavedNewsBloc, SavedNewsState>(
              builder: (context, state) {
                if (state.id.contains(news.id)) {
                  return const Icon(
                    Icons.bookmark,
                    size: 40,
                  );
                } else {
                  return const Icon(
                    Icons.bookmark_border_outlined,
                    size: 40,
                  );
                }
              },
            ),
            onPressed: () {
              context
                  .read<SavedNewsBloc>()
                  .add(ToggleSavedNewsEvent(savedNews: news));
            },
          ),
          IconButton(
            padding: const EdgeInsets.only(right: 15),
            icon: const Icon(
              Icons.settings,
              size: 40,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  double fontSize =
                      context.watch<FontSizeBloc>().state.fontSize;
                  return AlertDialog(
                    content: SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: Column(
                        children: [
                          const Text("Font Size"),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 6,
                            width: double.maxFinite,
                            child: Text(
                              'AaBbCcDdEeFfGh123456',
                              style:
                                  Theme.of(context).textTheme.bodyText1!.merge(
                                        TextStyle(
                                          fontSize: context
                                              .watch<FontSizeBloc>()
                                              .state
                                              .fontSize,
                                        ),
                                      ),
                            ),
                          ),
                          Slider(
                            value: fontSize,
                            min: 21,
                            max: 35,
                            divisions: 10,
                            label: fontSize.round().toString(),
                            onChanged: (double value) {
                              context
                                  .read<FontSizeBloc>()
                                  .add(ChangeFontSizeEvent(fontSize: value));
                            },
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Apply',
                              style:
                                  Theme.of(context).textTheme.bodyText2!.merge(
                                        TextStyle(
                                          color: themeLightColor2,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                barrierDismissible: false,
              );
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
        style: Theme.of(context).textTheme.bodyText1!.merge(
              TextStyle(
                fontSize: context.watch<FontSizeBloc>().state.fontSize,
              ),
            ),
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
        style: Theme.of(context).textTheme.bodyText1!.merge(
              TextStyle(
                fontSize: context.watch<FontSizeBloc>().state.fontSize,
              ),
            ),
      ),
    );
  }
}
