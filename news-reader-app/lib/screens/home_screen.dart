import 'package:flutter/material.dart';
import '../models/article_model.dart';
import '../services/news_service.dart';
import '../widgets/article_tile.dart';
import 'article_detail_screen.dart';

/// Home screen displaying the list of top headlines
/// Uses FutureBuilder for async data fetching
/// Includes pull-to-refresh functionality
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NewsService _newsService = NewsService();
  late Future<List<Article>> _articlesFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the future to fetch articles
    _articlesFuture = _newsService.fetchTopHeadlines();
  }

  /// Refresh articles - called by pull-to-refresh
  Future<void> _refreshArticles() async {
    setState(() {
      // Force refresh by bypassing cache
      _articlesFuture = _newsService.fetchTopHeadlines(forceRefresh: true);
    });
  }

  /// Navigate to article detail screen
  void _navigateToDetail(Article article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleDetailScreen(article: article),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Top Headlines',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          // Refresh button in app bar
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshArticles,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshArticles,
        child: FutureBuilder<List<Article>>(
          future: _articlesFuture,
          builder: (context, snapshot) {
            // Loading state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text(
                      'Loading articles...',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            }

            // Error state
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red[300],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Oops! Something went wrong',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        snapshot.error.toString(),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: _refreshArticles,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Try Again'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            // Success state with data
            if (snapshot.hasData) {
              final articles = snapshot.data!;

              // Empty state - no articles found
              if (articles.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.article_outlined,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No articles found',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Pull down to refresh',
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                );
              }

              // Display articles in a list
              return ListView.builder(
                // Important: Makes the entire list scrollable for RefreshIndicator
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: articles.length,
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return ArticleTile(
                    article: article,
                    onTap: () => _navigateToDetail(article),
                  );
                },
              );
            }

            // Fallback state (should rarely reach here)
            return const Center(
              child: Text('No data available'),
            );
          },
        ),
      ),
    );
  }
}
