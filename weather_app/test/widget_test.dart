// This is a basic Flutter widget test for the Weather App.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:weather_app/main.dart';

void main() {
  testWidgets('Weather app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const WeatherApp());

    // Verify that the app bar title is present
    expect(find.text('Weather App'), findsOneWidget);

    // Verify that search and location icons are present in the app bar
    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.byIcon(Icons.my_location), findsOneWidget);

    // Wait for the widget to settle
    await tester.pump();
  });

  testWidgets('WeatherApp creates MaterialApp', (WidgetTester tester) async {
    await tester.pumpWidget(const WeatherApp());

    // Verify MaterialApp is created
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
