import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizly_app/pages/user_account.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  Map data = {
    "uid": "XXXXXXXXXXXXXXXXXXXXXXXXXXXX",
    "name": "Alan Turing",
    "nickname": "turingComplete",
    "picture": "https://firebasestorage.googleapis.com/v0/b/quizly-70118.appspot.com/o/unknown_user.png?alt=media&token=082b6b49-2ad6-4d57-a93f-47f5a82041e4",
    "win": 0,
    "lose": 0,
    "favourite_category": "-",
    "max_points": 0
  };

  testWidgets('Widget UserAccount displays user\'s nickname',
      (WidgetTester tester) async {
    mockNetworkImagesFor(() async {
      Widget testWidget = MediaQuery(
          data: const MediaQueryData(),
          child: MaterialApp(
              home: UserAccount(values: data,)
          ));
      await tester.pumpWidget(testWidget);
      expect(find.text(data['nickname']), findsOneWidget);
    });
  });

  testWidgets('Widget UserAccount displays user\'s stats',
      (WidgetTester tester) async {
    mockNetworkImagesFor(() async {
      Widget testWidget = MediaQuery(
          data: const MediaQueryData(),
          child: MaterialApp(
              home: UserAccount(values: data,)
          )
      );
      await tester.pumpWidget(testWidget);
      expect(find.text('Ratio: '), findsOneWidget);
      expect(find.text('${data['win']}:${data['lose']}'), findsOneWidget);
      expect(find.text('Favourite quiz: '), findsOneWidget);
      expect(find.text(data['favourite_category']), findsOneWidget);
      expect(find.text('Most points: '), findsOneWidget);
      expect(find.text('${data['max_points']}'), findsOneWidget);
    });
  });
}
