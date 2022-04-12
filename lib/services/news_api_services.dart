import 'dart:convert';

import 'package:news_app_with_firebase/models/news.dart';
import 'package:http/http.dart' as http;

class NewsApiServices {
  Future<List<News>?> getNews() async {
    String apiKey = 'pub_63780dcbb382588eb4975b85906a0dcbbd43';
    final Uri uri =
        Uri.parse('https://newsdata.io/api/1/news?apikey=$apiKey&country=au');

    try {
      final http.Response response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception('response.statusCode != 200');
      }

      final newsJson = json.decode(response.body)['results'];
      List<News> results =
          (newsJson as List).map((e) => News.fromJson(e)).toList();
      //print(results[0].title);
      return results;
    } catch (e) {
      rethrow;
    }
  }
}
