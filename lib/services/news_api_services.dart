import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app_with_firebase/constants/constants.dart';
import 'package:news_app_with_firebase/models/news.dart';

class NewsApiServices {
  final http.Client httpClient;
  NewsApiServices({
    required this.httpClient,
  });

  Future<List<News>?> getLatestNews() async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kNewsHost,
      path: '/api/1/news',
      queryParameters: {
        'apikey': apiKey,
        'country': 'ph',
        'language': 'en',
      },
    );

    try {
      final http.Response response =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      if (response.statusCode != 200) {
        throw Exception('response.statusCode != 200');
      }

      final newsJson = json.decode(utf8.decode(response.bodyBytes))['results'];
      List<News> results =
          (newsJson as List).map((e) => News.fromJson(e)).toList();

      return results;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<News>?> getAroundTheWorldNews() async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kNewsHost,
      path: '/api/1/news',
      queryParameters: {
        'apikey': apiKey,
        'country': 'au,ca,gb,ch',
        'language': 'en',
      },
    );

    try {
      final http.Response response =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      if (response.statusCode != 200) {
        throw Exception('response.statusCode != 200');
      }

      final newsJson = json.decode(utf8.decode(response.bodyBytes))['results'];
      List<News> results =
          (newsJson as List).map((e) => News.fromJson(e)).toList();

      return results;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<News>?> getNewsByCategory(String category) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kNewsHost,
      path: '/api/1/news',
      queryParameters: {
        'apikey': apiKey,
        'category': category,
        'language': 'en',
      },
    );

    try {
      final http.Response response =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      if (response.statusCode != 200) {
        throw Exception('response.statusCode != 200');
      }

      final newsJson = json.decode(utf8.decode(response.bodyBytes))['results'];
      List<News> results =
          (newsJson as List).map((e) => News.fromJson(e)).toList();

      return results;
    } catch (e) {
      rethrow;
    }
  }
}
