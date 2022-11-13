import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizly_app/pages/user_account.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('Widget UserAccount displays user\'s nickname',
      (WidgetTester tester) async {
    mockNetworkImagesFor(() async {
      Widget testWidget = MediaQuery(
          data: const MediaQueryData(),
          child: MaterialApp(
              home: UserAccount(
            url: '',
            name: 'IronMan73',
          )));
      await tester.pumpWidget(testWidget);
      expect(find.text('IronMan73'), findsOneWidget);
    });
  });

  testWidgets('Widget UserAccount displays user\'s stats',
      (WidgetTester tester) async {
    mockNetworkImagesFor(() async {
      Widget testWidget = MediaQuery(
          data: const MediaQueryData(),
          child: MaterialApp(
              home: UserAccount(
            w: 5,
            l: 2,
            cat: 'Cats',
            friend: 52,
            points: 420,
          )));
      await tester.pumpWidget(testWidget);
      expect(find.text('Ratio: '), findsOneWidget);
      expect(find.text('5:2'), findsOneWidget);
      expect(find.text('Favourite quiz: '), findsOneWidget);
      expect(find.text('Cats'), findsOneWidget);
      expect(find.text('Friends: '), findsOneWidget);
      expect(find.text('52'), findsOneWidget);
      expect(find.text('Most points: '), findsOneWidget);
      expect(find.text('420'), findsOneWidget);
    });
  });
}
