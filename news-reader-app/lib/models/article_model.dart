/// Model class representing a news article
/// Parses JSON data from NewsAPI.org response
class Article {
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final DateTime publishedAt;
  final String? content;
  final Source? source;

  Article({
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
    this.source,
  });

  /// Factory constructor to create Article from JSON
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      author: json['author'] as String?,
      title: json['title'] as String? ?? 'No Title',
      description: json['description'] as String?,
      url: json['url'] as String? ?? '',
      urlToImage: json['urlToImage'] as String?,
      publishedAt: DateTime.parse(json['publishedAt'] as String),
      content: json['content'] as String?,
      source: json['source'] != null 
          ? Source.fromJson(json['source'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Convert Article to JSON (for potential caching)
  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt.toIso8601String(),
      'content': content,
      'source': source?.toJson(),
    };
  }
}

/// Model class for article source
class Source {
  final String? id;
  final String name;

  Source({
    this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'] as String?,
      name: json['name'] as String? ?? 'Unknown Source',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
