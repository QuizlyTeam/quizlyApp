import 'dart:io';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:quizly_app/pages/category_page.dart';
import 'package:flutter/material.dart';
import 'package:nock/nock.dart';

void main() {
  testWidgets('Widget Home display Image', (WidgetTester tester) async {
    setUpAll(nock.init);

    setUp(() {
      nock.cleanAll();
    });

    testWidgets('Should test widget with http call', (WidgetTester tester) async {
      nock('http://127.0.0.1')
          .get('/v1/quizzes/categories')
          .reply(200, json.encode('{"categories": ["Arts & Literature","Film & TV","Food & Drink","General Knowledge","Geography","History","Music","Science","Society & Culture","Sport & Leisure"]}'));



    await tester.pumpWidget(const CategoryPage());
    /*expect(find.text("Film & TV"), findsOneWidget);
    expect(find.text("Arts & Literature"), findsOneWidget);
    expect(find.text("Food & Drink"), findsOneWidget);
    expect(find.text("General Knowledge"), findsOneWidget);
    expect(find.text("Science"), findsOneWidget);
    expect(find.text("History"), findsOneWidget);
    expect(find.text("Sport & Leisure"), findsOneWidget);*/
  });
});
}