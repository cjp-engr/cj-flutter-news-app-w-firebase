import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:news_app_with_firebase/blocs/active_category/active_category_bloc.dart';
import 'package:news_app_with_firebase/constants/constants.dart';
import 'package:news_app_with_firebase/models/news.dart';

class ArticleSection extends StatelessWidget {
  final News news;
  const ArticleSection({
    Key? key,
    required this.news,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(news.categories!),
        actions: [
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.font,
              size: 30,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.bookmark,
              size: 30,
            ),
            onPressed: () {
              context
                  .read<ActiveCategoryBloc>()
                  .add(ToggleSavedNewsEvent(id: news.id));
              print(news.id);
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
        news.title != null ? loremIpsumParagraph.substring(0, 40) : news.title!,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }

  Widget _description(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        news.description != null
            ? loremIpsumParagraph.substring(0, 100)
            : news.description!,
        style: Theme.of(context).textTheme.bodyText1,
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
    // String content = news.content!.toString().trim().replaceAll('.', '\n\n');
    // String fullDesc =
    //     news.fullDescription!.toString().trim().replaceAll('.', '\n\n');
    // String lorem =
    //     loremIpsumParagraph.toString().trim().replaceAll('.', '\n\n');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        // news.content != null
        //     ? news.content!
        //     : news.fullDescription != null
        //         ? news.fullDescription!
        //         :
        loremIpsumParagraph,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
