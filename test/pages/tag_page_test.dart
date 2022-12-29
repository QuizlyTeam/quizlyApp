import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:quizly_app/pages/tag_page.dart';
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
    final interceptor = nock("http://10.0.2.2:8000/v1/quizzes").get("/tags")
      ..reply(200, '{"tags": ["alcohol","acting"]}');

    final response =
        await http.get(Uri.parse("http://10.0.2.2:8000/v1/quizzes/tags"));

    expect(interceptor.isDone, true);
    expect(response.statusCode, 200);
    expect(response.body, '{"tags": ["alcohol","acting"]}');
  });

  testWidgets('Widget display category test', (WidgetTester tester) async {
    await tester.runAsync(() async {
      final interceptor = nock("http://10.0.2.2:8000").get("/v1/quizzes/tags")
        ..reply(
          200,
          '{"tags": ["alcohol","acting"]}',
        );

      final response =
          await http.get(Uri.parse("http://10.0.2.2:8000/v1/quizzes/tags"));
      final returnedList = fetchTags();
      List<String> list = ["alcohol", "acting"];
      FutureBuilder<List<String>>(
          future: returnedList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              expect(interceptor.isDone, true);
              expect(response.statusCode, 200);
              expect(response.body, '{"tags": ["alcohol","acting"]}');
              expect(snapshot.data!, list);

              tester.pumpWidget(const MaterialApp(home: TagPage()));
              expect(find.byKey(const Key("CPR")), findsOneWidget);

              addDelay(2000);
              tester.pump();
              addDelay(2000);

              final catName = find.text("alcohol");
              expect(find.byKey(const Key("tagButton")), findsOneWidget);
              expect(catName, findsOneWidget);
            }
            return Column();
          });
    });
  });
}
