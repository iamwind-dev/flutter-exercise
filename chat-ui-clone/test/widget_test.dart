// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chat_ui_clone/main.dart';

void main() {
  testWidgets('Chat UI Clone app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ChatUICloneApp());

    // Verify that the chat screen loads with AI Bot title
    expect(find.text('AI Bot'), findsOneWidget);
    
    // Verify that the message input field is present
    expect(find.byType(TextField), findsOneWidget);
  });
}
