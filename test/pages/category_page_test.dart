import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:quizly_app/pages/category_page.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'category_page_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('fetchAlbum', () {
    test('returns an List<String> if the http call completes successfully',
        () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse('http://10.0.2.2:8000/v1/quizzes/categories')))
          .thenAnswer((_) async => http.Response(
              '{"categories": ["Arts & Literature","Film & TV","Food & Drink","General Knowledge","Geography","History","Music","Science","Society & Culture","Sport & Leisure"]}',
              200));

      expect(await fetchCategories(client), isA<List<String>>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      when(client.get(Uri.parse('http://10.0.2.2:8000/v1/quizzes/categories')))
          .thenAnswer((_) async => http.Response('Something went wrong', 500));

      expect(fetchCategories(client), throwsException);
    });
  });
}
