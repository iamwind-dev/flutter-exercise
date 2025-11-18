import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

/// Main entry point of the Weather App
/// This app fetches and displays real-time weather data based on user location
void main() {
  runApp(const WeatherApp());
}

/// Root widget of the application
class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // App title
      title: 'Weather App',
      
      // Remove debug banner in release mode
      debugShowCheckedModeBanner: false,
      
      // Apply custom theme
      theme: AppTheme.lightTheme,
      
      // Set home screen
      home: const HomeScreen(),
    );
  }
}
