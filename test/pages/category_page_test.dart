import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:quizly_app/pages/category_page.dart';
import 'package:nock/nock.dart';

addDelay(int millis) async {
  await Future.delayed(Duration(milliseconds: millis));
}

void main() {
  setUpAll(() {
    nock.init();
  });

  setUp(() {
    nock.cleanAll();
  });

  test("http.get test", () async {
    final interceptor =
        nock("http://10.0.2.2:8000/v1/quizzes").get("/categories")
          ..reply(
            200,
            '{"categories": ["Arts & Literature","Film & TV","Food & Drink","General Knowledge","Geography","History","Music","Science","Society & Culture","Sport & Leisure"]}',
          );

    final response =
        await http.get(Uri.parse("http://10.0.2.2:8000/v1/quizzes/categories"));

    expect(interceptor.isDone, true);
    expect(response.statusCode, 200);
    expect(response.body,
        '{"categories": ["Arts & Literature","Film & TV","Food & Drink","General Knowledge","Geography","History","Music","Science","Society & Culture","Sport & Leisure"]}');
  });

  testWidgets('Widget display category test', (WidgetTester tester) async {
    await tester.runAsync(() async {
      final interceptor =
          nock("http://10.0.2.2:8000").get("/v1/quizzes/categories")
            ..reply(
              200,
              '{"categories": ["Arts & Literature","Film & TV","Food & Drink","General Knowledge","Geography","History","Music","Science","Society & Culture","Sport & Leisure"]}',
            );

      final response = await http
          .get(Uri.parse("http://10.0.2.2:8000/v1/quizzes/categories"));
      final returnedList = fetchCategories();
      List<String> list = [
        "Arts & Literature",
        "Film & TV",
        "Food & Drink",
        "General Knowledge",
        "Geography",
        "History",
        "Music",
        "Science",
        "Society & Culture",
        "Sport & Leisure"
      ];
      FutureBuilder<List<String>>(
          future: returnedList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              expect(interceptor.isDone, true);
              expect(response.statusCode, 200);
              expect(response.body,
                  '{"categories": ["Arts & Literature","Film & TV","Food & Drink","General Knowledge","Geography","History","Music","Science","Society & Culture","Sport & Leisure"]}');
              expect(snapshot.data!, list);

              tester.pumpWidget(const MaterialApp(home: CategoryPage()));
              expect(find.byKey(const Key("CPR")), findsOneWidget);

              addDelay(2000);
              tester.pump();
              addDelay(2000);

              final catName = find.text("Geography");
              final catIcon =
                  find.image(const AssetImage('assets/images/global.png'));
              expect(find.byKey(const Key("categoryButton")), findsOneWidget);
              expect(catIcon, findsOneWidget);
              expect(catName, findsOneWidget);
            }
            return Column();
          });
    });
  });
}
