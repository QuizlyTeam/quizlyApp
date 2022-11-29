import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizly_app/pages/question.dart';

void main() {
  testWidgets('Widget Home display Image', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(Question(
        category: "Film & TV",
      ));
      expect(find.image(const AssetImage('assets/images/back.png')),
          findsOneWidget);
      expect(find.image(const AssetImage('assets/images/back.png')),
          findsOneWidget);
      expect(find.image(const AssetImage('assets/images/settings.png')),
          findsOneWidget);
    });
  });
}
