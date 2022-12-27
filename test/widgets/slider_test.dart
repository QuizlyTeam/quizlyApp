import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizly_app/widgets/slider.dart';

void main() {
  testWidgets('Widget Home display Image', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
        home: QuizlySlider(), ));
    expect(find.byKey(const Key('suwak')), findsOneWidget);
  });
}
