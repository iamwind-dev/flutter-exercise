import 'package:flutter/material.dart';
import 'screens/chat_screen.dart';
import 'theme/app_theme.dart';

/// Main entry point of the Chat UI Clone app
void main() {
  runApp(const ChatUICloneApp());
}

/// Root widget of the application
class ChatUICloneApp extends StatelessWidget {
  const ChatUICloneApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat UI Clone',
      debugShowCheckedModeBanner: false,
      
      // Apply custom theme
      theme: AppTheme.lightTheme(),
      
      // Set chat screen as home
      home: const ChatScreen(),
    );
  }
}
