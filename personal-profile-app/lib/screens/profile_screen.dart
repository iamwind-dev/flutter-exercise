import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/info_tile.dart';
import '../widgets/skill_chip.dart';

/// ProfileScreen is the main screen that displays the user's personal profile.
/// It showcases various Flutter layout widgets and demonstrates responsive design.
/// The screen includes profile header, contact info, skills, and social links.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  // Animation controller for fade-in effect
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // Create fade-in animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    // Start the animation when the screen loads
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Opens a URL in the default browser or app
  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  /// Builds the profile header section with avatar, name, role, and bio
  Widget _buildProfileHeader(BuildContext context) {
    final theme = Theme.of(context);
    // Use LayoutBuilder to make layout responsive
    return LayoutBuilder(
      builder: (context, constraints) {
        // Adjust avatar size based on screen width
        final avatarRadius = constraints.maxWidth < 600 ? 60.0 : 80.0;
        
        return Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Profile Avatar
                CircleAvatar(
                  radius: avatarRadius,
                  backgroundColor: theme.colorScheme.primary,
                  // If you have a profile image, use this instead:
                  // backgroundImage: AssetImage('assets/images/profile.jpg'),
                  child: Icon(
                    Icons.person,
                    size: avatarRadius,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),

                // Name
                Text(
                  'John Developer',
                  style: theme.textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),

                // Role
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    ' Flutter Developer',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Bio
                Text(
                  'Passionate mobile developer with expertise in building beautiful, '
                  'high-performance cross-platform applications using Flutter. '
                  'I love creating intuitive user experiences and clean code.',
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Builds the contact information section
  Widget _buildContactSection() {
    return Column(
      children: [
        // Section title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Contact Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),

        // Contact information tiles
        InfoTile(
          icon: Icons.email,
          title: 'Email',
          subtitle: 'duongdinh304@gmail.com',
          url: 'mailto:duongdinh304@gmail.com',
        ),
        InfoTile(
          icon: Icons.phone,
          title: 'Phone',
          subtitle: '+84 353993283',
          url: 'tel:+84353993283',
        ),
        InfoTile(
          icon: Icons.code,
          title: 'GitHub',
          subtitle: 'github.com/iamwind-dev',
          url: 'https://github.com/iamwind-dev',
          iconColor: Colors.black,
        ),
        InfoTile(
          icon: Icons.business,
          title: 'LinkedIn',
          subtitle: 'linkedin.com/in/duongdinh304',
          url: 'https://linkedin.com/in/duongdinh304',
          iconColor: const Color(0xFF0077B5),
        ),
      ],
    );
  }

  /// Builds the skills section with chips
  Widget _buildSkillsSection() {
    // Define skills with optional icons and colors
    final skills = [
      {'name': 'Flutter', 'icon': Icons.flutter_dash},
      {'name': 'Dart', 'icon': Icons.code},
      {'name': 'Firebase', 'icon': Icons.cloud},
      {'name': 'REST APIs', 'icon': Icons.api},
      {'name': 'State Management', 'icon': Icons.settings},
      {'name': 'UI/UX Design', 'icon': Icons.design_services},
      {'name': 'Git', 'icon': Icons.code_off},
      {'name': 'Responsive Design', 'icon': Icons.phone_android},
      {'name': 'Material Design', 'icon': Icons.palette},
      {'name': 'iOS & Android', 'icon': Icons.smartphone},
    ];

    return SkillsSection(
      title: 'Technical Skills',
      skills: skills,
    );
  }

  /// Builds the social links section with icon buttons
  Widget _buildSocialLinks(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Section title
            Row(
              children: [
                Icon(
                  Icons.share,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Connect With Me',
                  style: theme.textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Social media icon buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSocialButton(
                  icon: Icons.code,
                  label: 'GitHub',
                  color: Colors.black,
                  url: 'https://github.com/iamwind-dev',
                ),
                _buildSocialButton(
                  icon: Icons.business,
                  label: 'LinkedIn',
                  color: const Color(0xFF0077B5),
                  url: 'https://www.linkedin.com/in/th%C3%A1i-d%C6%B0%C6%A1ng-undefined-a54b3a35b',
                ),
                _buildSocialButton(
                  icon: Icons.alternate_email,
                  label: 'Twitter',
                  color: const Color(0xFF1DA1F2),
                  url: 'https://twitter.com/iawindd',
                ),
                _buildSocialButton(
                  icon: Icons.web,
                  label: 'Portfolio',
                  color: theme.colorScheme.primary,
                  url: 'https://example.com',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Helper method to build individual social media buttons
  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required Color color,
    required String url,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: () => _launchUrl(url),
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Responsive layout: use different layouts for mobile and web/tablet
              final isWideScreen = constraints.maxWidth > 800;

              if (isWideScreen) {
                // Two-column layout for wider screens
                return _buildWideLayout();
              } else {
                // Single-column scrollable layout for mobile
                return _buildMobileLayout();
              }
            },
          ),
        ),
      ),
    );
  }

  /// Mobile layout with vertical scrolling
  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildProfileHeader(context),
          const Divider(),
          _buildContactSection(),
          const Divider(),
          _buildSkillsSection(),
          const Divider(),
          _buildSocialLinks(context),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  /// Wide screen layout with two columns
  Widget _buildWideLayout() {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                _buildProfileHeader(context),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left column
                    Expanded(
                      child: Column(
                        children: [
                          _buildContactSection(),
                          const SizedBox(height: 24),
                          _buildSocialLinks(context),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    // Right column
                    Expanded(
                      child: _buildSkillsSection(),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
