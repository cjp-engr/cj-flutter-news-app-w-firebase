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
      host: kHost,
      path: '/api/1/news',
      queryParameters: {
        'apikey': apiKey,
        'country': 'au',
      },
    );
    //print(uri.toString());

    try {
      final http.Response response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception('response.statusCode != 200');
      }

      final newsJson = json.decode(response.body)['results'];
      List<News> results =
          (newsJson as List).map((e) => News.fromJson(e)).toList();
      return results;
    } catch (e) {
      rethrow;
    }
  }
}
