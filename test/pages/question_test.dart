import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizly_app/pages/question.dart';

void main() {
  testWidgets('Widget Home display Image', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(const Question(
          question: "Jakiego kraju \n to flaga?",
          ans1: "Kiribati",
          ans2: "Liberia",
          ans3: "Tuvalu",
          ans4: "Macedonia",
          correctAnswer: "Kiribati"),);
      expect(
          find.image(const AssetImage('assets/images/back.png')),
          findsOneWidget);
      expect(
          find.image(const AssetImage('assets/images/back.png')),
          findsOneWidget);
      expect(find.image(const AssetImage('assets/images/settings.png')),
          findsOneWidget);
      expect(
          find.image(const AssetImage('assets/images/flag.png')),
          findsOneWidget);
    });
  });
}
