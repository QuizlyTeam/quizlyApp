import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizly_app/auth/auth.dart';
import 'package:quizly_app/pages/my_quizzes_page.dart';
import 'package:http/http.dart' as http;

import '../widgets/mock.dart';
import 'package:nock/nock.dart';

addDelay(int millis) async {
  await Future.delayed(Duration(milliseconds: millis));
}

void main() async {
  setUpAll(() {
    nock.init();
  });

  setUp(() {
    nock.cleanAll();
  });

  setupFirebaseAuthMocks();
  TestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  testWidgets('Test quiz fetching', (WidgetTester tester) async {
    await tester.runAsync(() async {
      final interceptor = nock("http://10.0.2.2:8000").get("/v1/quizzes/")
        ..reply(
          200,
          '{"YYYYYYYYYYYYYYYYYYYY": {"category": "History","difficulty": "easy","questions": [{"correct_answer": "in London in 1912","incorrect_answers": ["in Manchester in 1901","in Oxford in 1924","in Cambridge in 1935"],"question": "Where and when was Alan Turing born?"},{"correct_answer": "a Turing Machine","incorrect_answers": ["the Bombe","Church\'s Computer","the Manchester Mach I"],"question": "Turing, while solving the Decision Problem, proposed a hypothetical computing machine, which we now call ___"}],"tags": "1910\'s","title": "Turing","uid": "XXXXXXXXXXXXXXXXXXXXXXXXXXXX"}}',
        );

      final response =
          await http.get(Uri.parse("http://10.0.2.2:8000/v1/quizzes/"));

      var result = getQuizzes();

      FutureBuilder<dynamic>(
          future: result,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {}
            if (snapshot.hasData) {
              expect(interceptor.isDone, true);
              expect(response.statusCode, 200);
              expect(
                response.body,
                '{"YYYYYYYYYYYYYYYYYYYY": {"category": "History","difficulty": "easy","questions": [{"correct_answer": "in London in 1912","incorrect_answers": ["in Manchester in 1901","in Oxford in 1924","in Cambridge in 1935"],"question": "Where and when was Alan Turing born?"},{"correct_answer": "a Turing Machine","incorrect_answers": ["the Bombe","Church\'s Computer","the Manchester Mach I"],"question": "Turing, while solving the Decision Problem, proposed a hypothetical computing machine, which we now call ___"}],"tags": "1910\'s","title": "The father of the computer","uid": "XXXXXXXXXXXXXXXXXXXXXXXXXXXX"}}',
              );
              tester.pumpWidget(const MaterialApp(home: MyQuizPage()));
              expect(find.text('The father of the...'), findsOneWidget);
              expect(find.text('Add a quiz'), findsOneWidget);
              expect(find.byType(ElevatedButton), findsNWidgets(1));
            }
            return Column();
          });
    });
  });

  testWidgets('Test quiz deleting', (WidgetTester tester) async {
    await tester.runAsync(() async {
      final interceptor = nock("http://10.0.2.2:8000").get("/v1/quizzes/")
        ..reply(
          200,
          '{"YYYYYYYYYYYYYYYYYYYY": {"category": "History","difficulty": "easy","questions": [{"correct_answer": "in London in 1912","incorrect_answers": ["in Manchester in 1901","in Oxford in 1924","in Cambridge in 1935"],"question": "Where and when was Alan Turing born?"},{"correct_answer": "a Turing Machine","incorrect_answers": ["the Bombe","Church\'s Computer","the Manchester Mach I"],"question": "Turing, while solving the Decision Problem, proposed a hypothetical computing machine, which we now call ___"}],"tags": "1910\'s","title": "Turing","uid": "XXXXXXXXXXXXXXXXXXXXXXXXXXXX"}}',
        );

      final response =
          await http.get(Uri.parse("http://10.0.2.2:8000/v1/quizzes/"));

      var result = getQuizzes();

      FutureBuilder<dynamic>(
          future: result,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {}
            if (snapshot.hasData) {
              expect(interceptor.isDone, true);
              expect(response.statusCode, 200);
              expect(
                response.body,
                '{"YYYYYYYYYYYYYYYYYYYY": {"category": "History","difficulty": "easy","questions": [{"correct_answer": "in London in 1912","incorrect_answers": ["in Manchester in 1901","in Oxford in 1924","in Cambridge in 1935"],"question": "Where and when was Alan Turing born?"},{"correct_answer": "a Turing Machine","incorrect_answers": ["the Bombe","Church\'s Computer","the Manchester Mach I"],"question": "Turing, while solving the Decision Problem, proposed a hypothetical computing machine, which we now call ___"}],"tags": "1910\'s","title": "The father of the computer","uid": "XXXXXXXXXXXXXXXXXXXXXXXXXXXX"}}',
              );
              tester.pumpWidget(const MaterialApp(home: MyQuizPage()));
              expect(find.text('The father of the...'), findsOneWidget);
              expect(find.text('Add a quiz'), findsOneWidget);
              expect(find.byType(ElevatedButton), findsNWidgets(1));

              tester.tap(find.byIcon(Icons.delete_forever_outlined));
              tester.pump(const Duration(seconds: 3));
              expect(find.text('The father of the...'), findsNothing);
            }
            return Column();
          });
    });
  });
}
