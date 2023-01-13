import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:quizly_app/pages/game_form.dart';

import '../widgets/mock.dart';
import 'package:nock/nock.dart';

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
  testWidgets('Test buttons', (WidgetTester tester) async {
    nock("http://10.0.2.2:8000").get("/v1/quizzes/")
      .reply(
        200,
        '{"YYYYYYYYYYYYYYYYYYYY": {"category": "History","difficulty": "easy","questions": [{"correct_answer": "in London in 1912","incorrect_answers": ["in Manchester in 1901","in Oxford in 1924","in Cambridge in 1935"],"question": "Where and when was Alan Turing born?"},{"correct_answer": "a Turing Machine","incorrect_answers": ["the Bombe","Church\'s Computer","the Manchester Mach I"],"question": "Turing, while solving the Decision Problem, proposed a hypothetical computing machine, which we now call ___"}],"tags": "1910\'s","title": "The father of the computer","uid": "XXXXXXXXXXXXXXXXXXXXXXXXXXXX"}}',
      );

    await tester.pumpWidget(MaterialApp(
        home: GameForm(
      uID: 'xxix',
      nick: 'user',
    )));

    expect(find.text('Play!'), findsOneWidget);
    expect(find.text('Difficulty level:'), findsOneWidget);
    expect(find.text('Pick'), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsNWidgets(3));
  });

  testWidgets('Test toggle tabs', (WidgetTester tester) async {
    nock("http://10.0.2.2:8000").get("/v1/quizzes/")
      .reply(
        200,
        '{"YYYYYYYYYYYYYYYYYYYY": {"category": "History","difficulty": "easy","questions": [{"correct_answer": "in London in 1912","incorrect_answers": ["in Manchester in 1901","in Oxford in 1924","in Cambridge in 1935"],"question": "Where and when was Alan Turing born?"},{"correct_answer": "a Turing Machine","incorrect_answers": ["the Bombe","Church\'s Computer","the Manchester Mach I"],"question": "Turing, while solving the Decision Problem, proposed a hypothetical computing machine, which we now call ___"}],"tags": "1910\'s","title": "The father of the computer","uid": "XXXXXXXXXXXXXXXXXXXXXXXXXXXX"}}',
      );
    await tester.pumpWidget(MaterialApp(
        home: GameForm(
      uID: 'xxix',
      nick: 'user',
    )));

    expect(find.text('Easy'), findsOneWidget);
    expect(find.text('Medium'), findsOneWidget);
    expect(find.byType(FlutterToggleTab), findsNWidgets(1));
  });

  testWidgets('Test tags and categories', (WidgetTester tester) async {
    nock("http://10.0.2.2:8000").get("/v1/quizzes/")
      .reply(
        200,
        '{"YYYYYYYYYYYYYYYYYYYY": {"category": "History","difficulty": "easy","questions": [{"correct_answer": "in London in 1912","incorrect_answers": ["in Manchester in 1901","in Oxford in 1924","in Cambridge in 1935"],"question": "Where and when was Alan Turing born?"},{"correct_answer": "a Turing Machine","incorrect_answers": ["the Bombe","Church\'s Computer","the Manchester Mach I"],"question": "Turing, while solving the Decision Problem, proposed a hypothetical computing machine, which we now call ___"}],"tags": "1910\'s","title": "The father of the computer","uid": "XXXXXXXXXXXXXXXXXXXXXXXXXXXX"}}',
      );
    await tester.pumpWidget(MaterialApp(
        home: GameForm(
      uID: 'xxix',
      nick: 'user',
    )));

    expect(find.text('Category'), findsOneWidget);
    expect(find.text('0 tags selected'), findsOneWidget);
  });
}
