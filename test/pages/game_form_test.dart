import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:quizly_app/pages/game_form.dart';

void main() {
  testWidgets('Test buttons', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: GameForm()));

    expect(find.text('Play!'), findsOneWidget);
    expect(find.text('Difficulty level:'), findsOneWidget);
    expect(find.text('Pick'), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsNWidgets(3));
  });

  testWidgets('Test toggle tabs', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: GameForm()));

    expect(find.text('Public'), findsOneWidget);
    expect(find.text('Private'), findsOneWidget);
    expect(find.text('Easy'), findsOneWidget);
    expect(find.text('Medium'), findsOneWidget);
    expect(find.byType(FlutterToggleTab), findsNWidgets(2));
  });

  testWidgets('Test tags and categories', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: GameForm()));

    expect(find.text('Category'), findsOneWidget);
    expect(find.text('0 tags selected'), findsOneWidget);
  });
}
