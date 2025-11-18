import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// InfoTile is a reusable widget for displaying contact information or links.
/// It combines an icon, title, subtitle, and optional tap functionality for opening URLs.
/// This demonstrates the DRY (Don't Repeat Yourself) principle by creating a reusable component.
class InfoTile extends StatelessWidget {
  /// The icon to display on the left side
  final IconData icon;
  
  /// The main text (e.g., "Email", "Phone")
  final String title;
  
  /// The detailed text (e.g., the actual email address or phone number)
  final String subtitle;
  
  /// Optional URL to open when tapped (e.g., "mailto:example@email.com")
  final String? url;
  
  /// Optional color for the icon (defaults to theme's primary color)
  final Color? iconColor;

  const InfoTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.url,
    this.iconColor,
  });

  /// Launches the URL when the tile is tapped
  /// Uses url_launcher package to open email clients, phone dialers, or web browsers
  Future<void> _launchUrl() async {
    if (url == null) return;

    final Uri uri = Uri.parse(url!);
    
    // Check if the URL can be launched
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // Open in external app
      );
    } else {
      // If URL can't be launched, we could show an error message
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the current theme for consistent styling
    final theme = Theme.of(context);
    
    return Card(
      // Add margin for spacing between tiles
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        // Leading icon with circular background
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (iconColor ?? theme.colorScheme.primary).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: iconColor ?? theme.colorScheme.primary,
          ),
        ),
        
        // Title text
        title: Text(
          title,
          style: theme.textTheme.titleMedium,
        ),
        
        // Subtitle text
        subtitle: Text(
          subtitle,
          style: theme.textTheme.bodyMedium,
        ),
        
        // Show trailing arrow if URL is provided (indicating it's tappable)
        trailing: url != null
            ? Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: theme.iconTheme.color?.withOpacity(0.5),
              )
            : null,
        
        // Make the tile tappable if URL is provided
        onTap: url != null ? _launchUrl : null,
        
        // Visual feedback when tapping
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
