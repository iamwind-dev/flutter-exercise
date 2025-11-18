import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App Theme Configuration
/// Contains color schemes and text styles for the chat app
class AppTheme {
  // Color palette
  static const Color primaryColor = Color(0xFF0084FF); // Messenger blue
  static const Color userBubbleColor = Color(0xFF0084FF); // User message color
  static const Color friendBubbleColor = Color(0xFFE4E6EB); // Friend message color
  static const Color backgroundColor = Color(0xFFF0F2F5); // Chat background
  static const Color inputBackgroundColor = Color(0xFFFFFFFF);
  static const Color textColorUser = Colors.white;
  static const Color textColorFriend = Color(0xFF050505);
  static const Color timestampColor = Color(0xFF65676B);
  static const Color appBarColor = Color(0xFFFFFFFF);
  static const Color onlineIndicatorColor = Color(0xFF31A24C);

  /// Light Theme
  static ThemeData lightTheme() {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: appBarColor,
        elevation: 2,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.poppins(
          fontSize: 16,
          color: Colors.black87,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.black87,
        ),
        bodySmall: GoogleFonts.poppins(
          fontSize: 12,
          color: timestampColor,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputBackgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        hintStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
      iconTheme: const IconThemeData(
        color: primaryColor,
      ),
    );
  }

  /// Dark Theme (optional - can be implemented later)
  static ThemeData darkTheme() {
    return ThemeData.dark().copyWith(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: const Color(0xFF18191A),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF242526),
        elevation: 2,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.poppins(
          fontSize: 16,
          color: Colors.white,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.white,
        ),
        bodySmall: GoogleFonts.poppins(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
    );
  }

  /// Text Styles
  static TextStyle messageTextUser = GoogleFonts.poppins(
    fontSize: 15,
    color: textColorUser,
  );

  static TextStyle messageTextFriend = GoogleFonts.poppins(
    fontSize: 15,
    color: textColorFriend,
  );

  static TextStyle timestampText = GoogleFonts.poppins(
    fontSize: 11,
    color: timestampColor,
  );

  static TextStyle senderNameText = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
}
