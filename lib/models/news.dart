class News {
  final String? title;
  final List<dynamic>? creators;
  final String? description;
  final String? content;
  final String? publishedDate;
  final String? imageUrl;
  final List<dynamic>? countries;
  final List<dynamic>? categories;
  final String? fullDescription;
  final bool? isSaved;
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
  });

  News.fromJson(Map<String, dynamic> json)
      : title = json['title'] ?? 'No Author',
        creators = json['creator'] ?? 'No Creator', //multiple data
        description = json['description'] ?? 'No Description',
        content = json['content'] ?? 'No Content',
        publishedDate = json['pubDate'] ?? 'No Published Date',
        imageUrl = json['image_url'] ?? 'No Image Url',
        countries = json['country'] ?? 'No Country', //multiple data
        categories = json['category'] ?? 'No Categories', //multiple data
        fullDescription = json['full_description'] ?? 'No Full Description',
        isSaved = false;

  factory News.initial() => News(
        title: '',
        creators: [],
        description: '',
        content: '',
        publishedDate: '',
        imageUrl: '',
        countries: [],
        categories: [],
        fullDescription: '',
        isSaved: false,
      );
}
