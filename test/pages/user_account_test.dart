import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizly_app/pages/user_account.dart';

void main() {
  testWidgets('Widget UserAccount displays user\'s nickname', (WidgetTester tester) async {
    Widget testWidget = MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(home: UserAccount())
    );
    await tester.pumpWidget(testWidget);
    expect(find.text('IronMan73'), findsOneWidget);
  });

  testWidgets('Widget UserAccount displays user\'s stats', (WidgetTester tester) async {
    Widget testWidget = MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(home: UserAccount())
    );
    await tester.pumpWidget(testWidget);
    expect(find.text('Ratio: '), findsOneWidget);
    expect(find.text('3:1'), findsOneWidget);
    expect(find.text('Favourite quiz: '), findsOneWidget);
    expect(find.text('Dogs'), findsOneWidget);
    expect(find.text('Friends: '), findsOneWidget);
    expect(find.text('31'), findsOneWidget);
    expect(find.text('Most points: '), findsOneWidget);
    expect(find.text('1043'), findsOneWidget);
  });
}