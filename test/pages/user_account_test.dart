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
}