class NewsException implements Exception {
  String message;
  NewsException([this.message = 'Something went wrong']) {
    message = 'News Exception: $message';
  }

  @override
  String toString() {
    return message;
  }
}
