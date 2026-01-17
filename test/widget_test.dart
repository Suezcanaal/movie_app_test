import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Import your main file to access MyApp
import 'package:movie_app_test/main.dart'; 

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the Splash Screen or Home Screen appears.
    // We look for a widget that we know exists in the app structure.
    // For example, finding a Container or the specific background color.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}