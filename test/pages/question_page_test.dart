import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizly_app/pages/question.dart';

void main() {
  testWidgets('Widget Home display Image', (WidgetTester tester) async {
    await tester.pumpWidget(const Questionpage());
    expect(
        find.image(const AssetImage('assets/images/back.png')), findsOneWidget);
    expect(
        find.image(const AssetImage('assets/images/back.png')), findsOneWidget);
    expect(find.image(const AssetImage('assets/images/settings.png')),
        findsOneWidget);
    expect(
        find.image(const AssetImage('assets/images/flag.png')), findsOneWidget);
    expect(
        find.image(const AssetImage('assets/images/time.png')), findsOneWidget);
  });
}
