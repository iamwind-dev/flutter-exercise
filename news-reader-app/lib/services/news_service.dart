import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

/// Service class to handle API calls to NewsAPI.org
/// Includes in-memory caching for better performance
class NewsService {
  // NewsAPI.org API key
  static const String _apiKey = '9ec735febb474e539c85479797cefc0a';
  static const String _baseUrl = 'https://newsapi.org/v2';
  
  // In-memory cache to store last fetched articles
  List<Article>? _cachedArticles;
  DateTime? _cacheTime;
  
  // Cache duration: 5 minutes
  static const Duration _cacheDuration = Duration(minutes: 5);

  /// Fetch top headlines from NewsAPI
  /// Returns a list of Article objects
  /// Throws an exception if the request fails
  Future<List<Article>> fetchTopHeadlines({
    String country = 'us',
    bool forceRefresh = false,
  }) async {
    // Return cached data if available and not expired
    if (!forceRefresh && _isCacheValid()) {
      print('Returning cached articles');
      return _cachedArticles!;
    }

    try {
      // Construct the API endpoint URL
      final url = Uri.parse(
        '$_baseUrl/top-headlines?country=$country&apiKey=$_apiKey',
      );

      print('Fetching articles from: $url');

      // Make the HTTP GET request
      final response = await http.get(url);

      // Check if request was successful
      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> jsonData = json.decode(response.body);
        
        // Check if the response status is 'ok'
        if (jsonData['status'] == 'ok') {
          // Extract articles array from response
          final List<dynamic> articlesJson = jsonData['articles'] ?? [];
          
          // Convert JSON array to List of Article objects
          final articles = articlesJson
              .map((json) => Article.fromJson(json as Map<String, dynamic>))
              .toList();
          
          // Cache the results
          _cachedArticles = articles;
          _cacheTime = DateTime.now();
          
          print('Successfully fetched ${articles.length} articles');
          return articles;
        } else {
          // API returned an error status
          throw Exception('API Error: ${jsonData['message'] ?? 'Unknown error'}');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Invalid API key. Please check your NewsAPI key.');
      } else if (response.statusCode == 429) {
        throw Exception('Too many requests. Please try again later.');
      } else {
        throw Exception(
          'Failed to load articles. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      // Handle any errors during the request
      print('Error fetching articles: $e');
      
      // Return cached data if available even if expired
      if (_cachedArticles != null) {
        print('Returning stale cached data due to error');
        return _cachedArticles!;
      }
      
      rethrow; // Re-throw the error if no cache available
    }
  }

  /// Search for articles by keyword
  Future<List<Article>> searchArticles(String query) async {
    try {
      final url = Uri.parse(
        '$_baseUrl/everything?q=$query&sortBy=publishedAt&apiKey=$_apiKey',
      );

      print('Searching articles with query: $query');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        
        if (jsonData['status'] == 'ok') {
          final List<dynamic> articlesJson = jsonData['articles'] ?? [];
          
          final articles = articlesJson
              .map((json) => Article.fromJson(json as Map<String, dynamic>))
              .toList();
          
          print('Found ${articles.length} articles for query: $query');
          return articles;
        } else {
          throw Exception('API Error: ${jsonData['message'] ?? 'Unknown error'}');
        }
      } else {
        throw Exception(
          'Failed to search articles. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error searching articles: $e');
      rethrow;
    }
  }

  /// Check if cached data is still valid
  bool _isCacheValid() {
    if (_cachedArticles == null || _cacheTime == null) {
      return false;
    }
    
    final now = DateTime.now();
    final difference = now.difference(_cacheTime!);
    
    return difference < _cacheDuration;
  }

  /// Clear the cache manually
  void clearCache() {
    _cachedArticles = null;
    _cacheTime = null;
    print('Cache cleared');
  }
}
