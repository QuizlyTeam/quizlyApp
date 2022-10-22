import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizly_app/pages/home.dart';

void main() {
  testWidgets('Widget Home display Image', (WidgetTester tester) async {
    await tester.pumpWidget(const Home());
    expect(find.image(const AssetImage('assets/images/quizly.png')), findsOneWidget);
  });
}
