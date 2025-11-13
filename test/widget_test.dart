// This is a basic Flutter widget test.
// It checks if the app builds correctly and runs without errors.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Import main.dart which contains the HealthApp class
import 'package:health_fitness_app/main.dart';

void main() {
  testWidgets('App builds without errors', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const HealthApp());

    // Verify: Ensure the application is built successfully
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
