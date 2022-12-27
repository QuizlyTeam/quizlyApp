import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizly_app/pages/login_page.dart';

void main() {
  testWidgets('Widget of login page', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home:LoginPage()));

    expect(find.text("Welcome to Quizly!"), findsOneWidget);
    expect(find.text("Sign in:"), findsOneWidget);
    expect(find.text("or"), findsOneWidget);
    expect(find.image(const AssetImage('assets/images/Group 5.png')),
        findsOneWidget);
    expect(
        find.image(
            const AssetImage('assets/images/Facebook (icon — Colour).png')),
        findsOneWidget);
    expect(
        find.image(
            const AssetImage('assets/images/Google (icon — Colour).png')),
        findsOneWidget);
    expect(find.image(const AssetImage('assets/images/Mask group.png')),
        findsOneWidget);
  });
}
