import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import '../models/article_model.dart';

/// Article detail screen showing full article information
/// Displays large image, title, description, author, and link to full article
class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailScreen({
    super.key,
    required this.article,
  });

  /// Launch the article URL in the browser
  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(article.url);
    
    try {
      // Check if the URL can be launched
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication, // Opens in external browser
        );
      } else {
        throw Exception('Could not launch URL');
      }
    } catch (e) {
      print('Error launching URL: $e');
      // Error will be handled by the calling context
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Format the published date
    final formattedDate = DateFormat('MMMM dd, yyyy • HH:mm').format(
      article.publishedAt,
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar with image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: article.urlToImage != null &&
                      article.urlToImage!.isNotEmpty
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        // Article image
                        Image.network(
                          article.urlToImage!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Center(
                                child: Icon(
                                  Icons.broken_image,
                                  size: 64,
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          },
                        ),
                        // Gradient overlay for better text visibility
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.7),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(
                          Icons.article,
                          size: 64,
                          color: Colors.grey,
                        ),
                      ),
                    ),
            ),
          ),

          // Article content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Source badge
                  if (article.source?.name != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        article.source!.name,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),

                  // Article title
                  Text(
                    article.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                  ),
                  const SizedBox(height: 16),

                  // Author and date information
                  Row(
                    children: [
                      // Author icon and name
                      if (article.author != null && article.author!.isNotEmpty)
                        Expanded(
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundColor:
                                    Theme.of(context).primaryColor.withOpacity(0.2),
                                child: Icon(
                                  Icons.person,
                                  size: 18,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  article.author!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Publication date
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        formattedDate,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Divider
                  Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                  ),
                  const SizedBox(height: 24),

                  // Article description
                  if (article.description != null &&
                      article.description!.isNotEmpty) ...[
                    Text(
                      article.description!,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            height: 1.6,
                            fontSize: 16,
                          ),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Article content (if available)
                  if (article.content != null && article.content!.isNotEmpty) ...[
                    Text(
                      article.content!,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            height: 1.6,
                            fontSize: 16,
                          ),
                    ),
                    const SizedBox(height: 32),
                  ],

                  // Read full article button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        try {
                          await _launchUrl();
                        } catch (e) {
                          // Show error message to user
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Could not open article: $e'),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        }
                      },
                      icon: const Icon(Icons.open_in_browser),
                      label: const Text(
                        'Read Full Article',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
