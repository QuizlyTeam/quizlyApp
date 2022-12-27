import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizly_app/widgets/header.dart';

void main() {
  testWidgets('Widget Home display Image', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
        home: Header(
      leftIcon: 'assets/images/back.png',
      rightIcon: 'assets/images/settings.png',
      y: 1,
    )));
    expect(
        find.image(const AssetImage('assets/images/back.png')), findsOneWidget);
    expect(
        find.image(const AssetImage('assets/images/back.png')), findsOneWidget);
    expect(find.image(const AssetImage('assets/images/settings.png')),
        findsOneWidget);
  });
}
