import 'package:flutter/material.dart';

/// SkillChip is a reusable widget for displaying individual skills.
/// It creates a visually appealing chip with an icon and label.
/// This widget demonstrates composition and reusability in Flutter.
class SkillChip extends StatelessWidget {
  /// The skill name to display
  final String label;
  
  /// Optional icon to display before the label
  final IconData? icon;
  
  /// Optional custom background color
  final Color? backgroundColor;
  
  /// Optional custom text color
  final Color? textColor;

  const SkillChip({
    super.key,
    required this.label,
    this.icon,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Chip(
      // Add icon if provided
      avatar: icon != null
          ? Icon(
              icon,
              size: 18,
              color: textColor ?? theme.colorScheme.primary,
            )
          : null,
      
      // Display the skill label
      label: Text(label),
      
      // Custom styling
      backgroundColor: backgroundColor ?? 
          theme.colorScheme.primary.withOpacity(0.1),
      
      labelStyle: TextStyle(
        color: textColor ?? theme.colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),
      
      // Add padding for better appearance
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      
      // Disable delete icon and make non-interactive
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}

/// SkillsSection displays a collection of skill chips in a wrapped layout.
/// It automatically arranges chips to fit the available width, wrapping to new lines as needed.
/// This demonstrates responsive layout using the Wrap widget.
class SkillsSection extends StatelessWidget {
  /// List of skills to display
  final List<Map<String, dynamic>> skills;
  
  /// Section title
  final String title;

  const SkillsSection({
    super.key,
    required this.skills,
    this.title = 'Skills',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section title
            Row(
              children: [
                Icon(
                  Icons.code,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Wrap widget arranges chips horizontally and wraps to new lines
            Wrap(
              spacing: 8, // Horizontal spacing between chips
              runSpacing: 8, // Vertical spacing between rows
              children: skills.map((skill) {
                return SkillChip(
                  label: skill['name'] as String,
                  icon: skill['icon'] as IconData?,
                  backgroundColor: skill['backgroundColor'] as Color?,
                  textColor: skill['textColor'] as Color?,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
