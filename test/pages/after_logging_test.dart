import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizly_app/pages/after_logging.dart';

void main() {
  testWidgets('Widget UserAccount creates buttons',
          (WidgetTester tester) async {
          Widget testWidget = const MediaQuery(
              data: MediaQueryData(),
              child: MaterialApp(
                  home:  AfterLogging(
                  )
              )
          );
          await tester.pumpWidget(testWidget);
          expect(find.byType(ElevatedButton), findsNWidgets(2));
          expect(find.text('Play'), findsOneWidget);
          expect(find.text('My quizzes'), findsOneWidget);
      });
}