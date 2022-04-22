import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_app_with_firebase/blocs/search_news/search_news_bloc.dart';
import 'package:news_app_with_firebase/constants/constants.dart';
import 'package:news_app_with_firebase/widgets/homepage/article_section.dart';
import 'package:news_app_with_firebase/widgets/searchnewspage/news_form_screen.dart';

class SearchNewsPage extends StatefulWidget {
  const SearchNewsPage({Key? key}) : super(key: key);

  @override
  State<SearchNewsPage> createState() => _SearchNewsPageState();
}

class _SearchNewsPageState extends State<SearchNewsPage> {
  String? _searchNews;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeLightColor2,
          title: Text(
            'Search News',
            style: TextStyle(color: themeLightColor1),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () async {
                _searchNews = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) {
                    return const NewsFormScreen();
                  }),
                );
                //print('city: $_searchNews');
                if (_searchNews != null) {
                  context
                      .read<SearchNewsBloc>()
                      .add(FetchSearchNewsEvent(keyword: _searchNews!));
                }
              },
            ),
          ],
        ),
        body: _showNews(),
      ),
    );
  }

  Widget _showNews() {
    return BlocConsumer<SearchNewsBloc, SearchNewsState>(
      listener: (context, state) {
        if (state.loadingStatus == SearchNewsLoadingStatus.error) {
          //errorDialog(context, state.customError.message);
          const Text('May error');
        }
      },
      builder: (context, state) {
        if (state.loadingStatus == SearchNewsLoadingStatus.initial) {
          return const Center(
            child: Text(
              'Search News',
              style: TextStyle(fontSize: 20.0),
            ),
          );
        }

        if (state.loadingStatus == SearchNewsLoadingStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.loadingStatus == SearchNewsLoadingStatus.error) {
          return const Center(
            child: Text(
              'Search News',
              style: TextStyle(fontSize: 20.0),
            ),
          );
        }

        if (state.loadingStatus == SearchNewsLoadingStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.separated(
          itemCount: state.newsResult.length,
          itemBuilder: (BuildContext context, int index) {
            var nList = state.newsResult.elementAt(index);
            return OpenContainer<bool>(
              openBuilder: (BuildContext _, VoidCallback openContainer) {
                return ArticleSection(
                  news: nList,
                  index: index,
                );
              },
              closedBuilder: (BuildContext _, VoidCallback openContainer) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(color: themeLightColor4, width: 10),
                        ),
                      ),
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
                                child: _creators(context, nList.creators!),
                              ),
                              Flexible(
                                child: _publishedDate(
                                    context, nList.publishedDate!),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          separatorBuilder: (_, int index) {
            return const Divider(
              color: Colors.white,
              height: 10,
            );
          },
        );
      },
    );
  }

  Widget _image(BuildContext context, String? imageUrl) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(20),
      ),
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
      bottom: 0,
      left: 0,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.1,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              title!.trim(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2!.merge(
                    TextStyle(
                      color: themeLightColor1,
                    ),
                  ),
              softWrap: true,
            ),
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
          padding: const EdgeInsets.all(5),
          child: Container(
            decoration: BoxDecoration(
              color: themeLightColor4,
              border: Border.all(color: themeLightColor1),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                country.trim(),
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

  Widget _creators(BuildContext context, List<dynamic> authors) {
    for (var creator in authors) {
      String author = creator.toString().trim().replaceAll(',', '\n');
      return Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          decoration: BoxDecoration(
            color: themeLightColor4,
            border: Border.all(color: themeLightColor1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 7, bottom: 7, left: 10, right: 10),
            child: Text(
              authors[0].toString().trim().contains(',')
                  ? author
                  : author.trim().length < 15
                      ? author
                      : author.substring(0, author.indexOf(' ') + 2) + '.',
              style: Theme.of(context).textTheme.caption!.merge(
                    TextStyle(
                      color: themeLightColor1,
                    ),
                  ),
            ),
          ),
        ),
      );
    }
    return const Text('Jane Doe');
  }

  Widget _publishedDate(BuildContext context, String pubDate) {
    final pDate = pubDate.substring(0, pubDate.indexOf(' ') + 1);
    final publishedDate =
        DateFormat.yMMMd().format(DateFormat('yyyy-MM-dd').parse(pDate));
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          color: themeLightColor4,
          border: Border.all(color: themeLightColor1),
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(5),
            topRight: Radius.circular(5),
            topLeft: Radius.circular(5),
          ),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 7, bottom: 7, left: 10, right: 10),
          child: Text(
            publishedDate.trim(),
            style: Theme.of(context).textTheme.caption!.merge(
                  TextStyle(
                    color: themeLightColor1,
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
