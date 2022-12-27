import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizly_app/pages/game_form.dart';

void main() {
  testWidgets('Widget GameForm properly show information',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: GameForm()));

    expect(find.text('Choose your'), findsOneWidget);
    expect(find.text('game options:'), findsOneWidget);
    expect(find.text('Private'), findsNWidgets(2));
    expect(find.text('Public'), findsOneWidget);
    expect(find.text('Pick'), findsOneWidget);
    expect(find.text('Play!'), findsOneWidget);
  });
}
