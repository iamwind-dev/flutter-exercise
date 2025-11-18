import 'package:flutter/material.dart';
import 'screens/profile_screen.dart';
import 'theme/app_theme.dart';

/// Main entry point of the Personal Profile App.
/// This app demonstrates Flutter layout, theming, and responsive design concepts.
void main() {
  runApp(const PersonalProfileApp());
}

/// Root widget of the application.
/// Manages the theme mode state and provides theme switching functionality.
class PersonalProfileApp extends StatefulWidget {
  const PersonalProfileApp({super.key});

  @override
  State<PersonalProfileApp> createState() => _PersonalProfileAppState();
}

class _PersonalProfileAppState extends State<PersonalProfileApp> {
  // Track whether dark mode is enabled
  bool _isDarkMode = false;

  /// Toggles between light and dark theme
  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // App title shown in task manager/recent apps
      title: 'Personal Profile App',
      
      // Remove debug banner in release mode
      debugShowCheckedModeBanner: false,
      
      // Apply light theme
      theme: AppTheme.lightTheme(),
      
      // Apply dark theme
      darkTheme: AppTheme.darkTheme(),
      
      // Current theme mode based on toggle state
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      
      // Home screen with theme toggle in AppBar
      home: Builder(
        builder: (context) {
          return Scaffold(
            // AppBar with theme toggle switch
            appBar: AppBar(
              title: const Text('Personal Profile'),
              actions: [
                // Theme toggle with icon and switch
                Row(
                  children: [
                    Icon(
                      _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    // Switch for toggling dark mode
                    Switch(
                      value: _isDarkMode,
                      onChanged: (value) => _toggleTheme(),
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
            // Main profile screen
            body: const ProfileScreen(),
          );
        },
      ),
    );
  }
}
