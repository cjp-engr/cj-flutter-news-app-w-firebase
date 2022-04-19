import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();

class News {
  final String? title;
  final List<dynamic>? creators;
  final String? description;
  final String? content;
  final String? publishedDate;
  final String? imageUrl;
  final String? countries;
  final String? categories;
  final String? fullDescription;
  final bool? isSaved;
  String id;
  News({
    this.title,
    this.creators,
    this.description,
    this.content,
    this.publishedDate,
    this.imageUrl,
    this.countries,
    this.categories,
    this.fullDescription,
    this.isSaved,
    required this.id,
  });

  News.fromJson(Map<String, dynamic> json)
      : title = json['title'] ?? 'No Author',
        creators = json['creator'] ?? ['Jane Doe'], //multiple data
        description = json['description'] ?? 'No Description',
        content = json['content'] ?? 'No Content',
        publishedDate = json['pubDate'] ?? 'No Published Date',
        imageUrl = json['image_url'] ?? 'https://picsum.photos/300',
        countries = json['country'][0] ?? 'No Country', //multiple data
        categories = json['category'][0] ?? 'No Categories', //multiple data
        fullDescription = json['full_description'] ?? 'No Full Description',
        isSaved = false,
        id = json['title']
            .toString()
            .trim()
            .substring(0, 15)
            .replaceAll(' ', '');

  factory News.initial() => News(
        title: '',
        creators: [],
        description: '',
        content: '',
        publishedDate: '',
        imageUrl: '',
        countries: '',
        categories: '',
        fullDescription: '',
        isSaved: false,
        id: '',
      );
}
