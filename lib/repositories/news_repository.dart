import 'package:news_app_with_firebase/exceptions/news_exception.dart';
import 'package:news_app_with_firebase/models/custom_error.dart';
import 'package:news_app_with_firebase/models/news.dart';
import 'package:news_app_with_firebase/services/news_api_services.dart';

class NewsRepository {
  final NewsApiServices newsApiServices;
  NewsRepository({
    required this.newsApiServices,
  });

  Future<List<News>?> fetchNewsList() async {
    try {
      List<News>? latestNews = await newsApiServices.getLatestNews();
      return latestNews;
    } on NewsException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}
