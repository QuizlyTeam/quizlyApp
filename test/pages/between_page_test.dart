import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizly_app/pages/between_page.dart';
import 'package:flutter/services.dart';

void main() {
  testWidgets("Check if text is shown properly", (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(home: BetweenPage(nick: "user",)));

    expect(find.text("Ready players:\n"
        "1/0\n"
        "Room id:\n"
        ""), findsOneWidget);
  });

  test("BetweenPage has correct default values", () {
    final BetweenPage page = BetweenPage(nick: "user");
    expect(page.nick, "user");
  });
}