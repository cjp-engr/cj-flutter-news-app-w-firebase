import 'package:news_app_with_firebase/exceptions/news_exception.dart';
import 'package:news_app_with_firebase/models/user_custom_error.dart';
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
      throw CustomError(message: e.message);
    } catch (e) {
      throw CustomError(message: e.toString());
    }
  }

  Future<List<News>?> fetchAroundTheNewsList() async {
    try {
      List<News>? latestNews = await newsApiServices.getAroundTheWorldNews();
      return latestNews;
    } on NewsException catch (e) {
      throw CustomError(message: e.message);
    } catch (e) {
      throw CustomError(message: e.toString());
    }
  }

  Future<List<News>?> fetchNewsByCategory(String category) async {
    try {
      List<News>? latestNews =
          await newsApiServices.getNewsByCategory(category);
      return latestNews;
    } on NewsException catch (e) {
      throw CustomError(message: e.message);
    } catch (e) {
      throw CustomError(message: e.toString());
    }
  }

  Future<List<News>?> fetchSearchNews(String keyword) async {
    try {
      List<News>? latestNews = await newsApiServices.getSearchNews(keyword);
      return latestNews;
    } on NewsException catch (e) {
      throw CustomError(message: e.message);
    } catch (e) {
      throw CustomError(message: e.toString());
    }
  }
}
