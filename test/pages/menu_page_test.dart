import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizly_app/pages/menu.dart';

void main() {
  testWidgets('Widget Home display Image', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
        home: MenuPage(
      nick: 'user',
    )));
    expect(find.image(const AssetImage('assets/images/profile.png')),
        findsOneWidget);
    expect(
        find.image(const AssetImage('assets/images/logo.png')), findsOneWidget);
    expect(find.image(const AssetImage('assets/images/settings.png')),
        findsOneWidget);
    expect(find.text('Create a quiz!'), findsOneWidget);
    expect(find.text('user'), findsOneWidget);
    expect(find.text('Play!'), findsOneWidget);
  });
}
