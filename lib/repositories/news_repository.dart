import 'package:news_app_with_firebase/models/news.dart';
import 'package:news_app_with_firebase/services/news_api_services.dart';

class NewsRepository {
  final NewsApiServices newsApiServices;
  NewsRepository({
    required this.newsApiServices,
  });

  // Future<List<News>> fetchNewsList() async {
  //   return null;
  // }
}
