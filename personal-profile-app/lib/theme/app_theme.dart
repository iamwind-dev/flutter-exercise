import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// AppTheme class provides centralized theme configuration for light and dark modes.
/// This ensures consistent styling across the entire app and makes theme switching easy.
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // Color constants for light mode
  static const Color _lightPrimaryColor = Color(0xFF6366F1); // Indigo
  static const Color _lightSecondaryColor = Color(0xFF8B5CF6); // Purple
  static const Color _lightBackgroundColor = Color(0xFFF8FAFC);
  static const Color _lightCardColor = Colors.white;
  static const Color _lightTextColor = Color(0xFF1E293B);

  // Color constants for dark mode
  static const Color _darkPrimaryColor = Color(0xFF818CF8); // Light Indigo
  static const Color _darkSecondaryColor = Color(0xFFA78BFA); // Light Purple
  static const Color _darkBackgroundColor = Color(0xFF0F172A);
  static const Color _darkCardColor = Color(0xFF1E293B);
  static const Color _darkTextColor = Color(0xFFF1F5F9);

  /// Light theme configuration
  /// Uses bright colors and high contrast for daylight viewing
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: _lightPrimaryColor,
      scaffoldBackgroundColor: _lightBackgroundColor,
      
      // Color scheme defines the app's color palette
      colorScheme: const ColorScheme.light(
        primary: _lightPrimaryColor,
        secondary: _lightSecondaryColor,
        surface: _lightCardColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: _lightTextColor,
      ),

      // Card theme for consistent card styling
      cardTheme: CardThemeData(
        color: _lightCardColor,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // AppBar theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: _lightBackgroundColor,
        foregroundColor: _lightTextColor,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: _lightTextColor,
        ),
      ),

      // Text theme using Poppins font
      textTheme: TextTheme(
        displayLarge: GoogleFonts.poppins(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: _lightTextColor,
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: _lightTextColor,
        ),
        headlineMedium: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: _lightTextColor,
        ),
        titleLarge: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: _lightTextColor,
        ),
        titleMedium: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: _lightTextColor,
        ),
        bodyLarge: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: _lightTextColor,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: _lightTextColor.withOpacity(0.8),
        ),
      ),

      // Icon theme
      iconTheme: const IconThemeData(
        color: _lightPrimaryColor,
        size: 24,
      ),

      // Divider theme
      dividerTheme: DividerThemeData(
        color: _lightTextColor.withOpacity(0.1),
        thickness: 1,
        space: 24,
      ),

      // Chip theme for skill chips
      chipTheme: ChipThemeData(
        backgroundColor: _lightPrimaryColor.withOpacity(0.1),
        labelStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: _lightPrimaryColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  /// Dark theme configuration
  /// Uses darker colors and softer contrast for low-light viewing
  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: _darkPrimaryColor,
      scaffoldBackgroundColor: _darkBackgroundColor,
      
      // Color scheme for dark mode
      colorScheme: const ColorScheme.dark(
        primary: _darkPrimaryColor,
        secondary: _darkSecondaryColor,
        surface: _darkCardColor,
        onPrimary: _darkBackgroundColor,
        onSecondary: _darkBackgroundColor,
        onSurface: _darkTextColor,
      ),

      // Card theme for dark mode
      cardTheme: CardThemeData(
        color: _darkCardColor,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // AppBar theme for dark mode
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: _darkBackgroundColor,
        foregroundColor: _darkTextColor,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: _darkTextColor,
        ),
      ),

      // Text theme for dark mode
      textTheme: TextTheme(
        displayLarge: GoogleFonts.poppins(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: _darkTextColor,
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: _darkTextColor,
        ),
        headlineMedium: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: _darkTextColor,
        ),
        titleLarge: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: _darkTextColor,
        ),
        titleMedium: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: _darkTextColor,
        ),
        bodyLarge: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: _darkTextColor,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: _darkTextColor.withOpacity(0.8),
        ),
      ),

      // Icon theme for dark mode
      iconTheme: const IconThemeData(
        color: _darkPrimaryColor,
        size: 24,
      ),

      // Divider theme for dark mode
      dividerTheme: DividerThemeData(
        color: _darkTextColor.withOpacity(0.1),
        thickness: 1,
        space: 24,
      ),

      // Chip theme for skill chips in dark mode
      chipTheme: ChipThemeData(
        backgroundColor: _darkPrimaryColor.withOpacity(0.2),
        labelStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: _darkPrimaryColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
