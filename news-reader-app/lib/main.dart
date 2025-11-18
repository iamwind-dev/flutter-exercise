import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';

/// Main entry point for the News Reader App
/// Fetches and displays latest headlines from NewsAPI.org
void main() {
  runApp(const NewsReaderApp());
}

/// Root widget of the application
/// Configures app theme and navigation
class NewsReaderApp extends StatelessWidget {
  const NewsReaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application title
      title: 'News Reader App',
      
      // Remove debug banner
      debugShowCheckedModeBanner: false,
      
      // App theme configuration
      theme: ThemeData(
        // Modern color scheme with blue as primary color
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1976D2), // Material Blue 700
          brightness: Brightness.light,
        ),
        
        // Use Poppins font throughout the app
        textTheme: GoogleFonts.poppinsTextTheme(),
        
        // AppBar theme
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color(0xFF1976D2),
          foregroundColor: Colors.white,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        
        // Elevated button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1976D2),
            foregroundColor: Colors.white,
            elevation: 2,
            textStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        
        // Card theme
        cardTheme: const CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        
        // Use Material 3 design
        useMaterial3: true,
      ),
      
      // Set home screen as the initial route
      home: const HomeScreen(),
    );
  }
}
