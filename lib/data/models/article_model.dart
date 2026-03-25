class Article {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String sourceName;

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.sourceName,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage:
          json['urlToImage'] ??
          'https://images.unsplash.com/photo-1504711432869-5d39a110fdd7?auto=format&fit=crop&q=80&w=800',
      publishedAt: json['publishedAt'] ?? '',
      sourceName: json['source']?['name'] ?? 'Unknown Source',
    );
  }
}
