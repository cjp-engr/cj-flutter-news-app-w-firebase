import 'package:equatable/equatable.dart';

class News extends Equatable {
  final String? title;
  final List<String>? creators;
  final String? description;
  final String? content;
  final String? publishedDate;
  final String? imageUrl;
  final List<String>? countries;
  final List<String>? categories;
  final String? fullDescription;
  const News({
    this.title,
    this.creators,
    this.description,
    this.content,
    this.publishedDate,
    this.imageUrl,
    this.countries,
    this.categories,
    this.fullDescription,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    final results = json['results']; //multiple data
    return News(
      title: results['title'],
      creators: results['creator'], //multiple data
      description: results['description'],
      content: results['content'],
      publishedDate: results['pubDate'],
      imageUrl: results['image_url'],
      countries: results['country'], //multiple data
      categories: results['category'], //multiple data
      fullDescription: results['full_description'],
    );
  }

  factory News.initial() => const News(
        title: '',
        creators: [],
        description: '',
        content: '',
        publishedDate: '',
        imageUrl: '',
        countries: [],
        categories: [],
        fullDescription: '',
      );

  @override
  List<Object?> get props => [
        title,
        creators,
        description,
        content,
        publishedDate,
        imageUrl,
        countries,
        categories,
        fullDescription,
      ];

  @override
  String toString() {
    return 'News(title: $title, creators: $creators, description: $description, content: $content, publishedDate: $publishedDate, imageUrl: $imageUrl, countries: $countries, categories: $categories, fullDescription: $fullDescription)';
  }
}
