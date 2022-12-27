import 'package:flutter_test/flutter_test.dart';
import 'package:quizly_app/pages/question.dart';

void main() {
  test('Question test', () {
    // Create an instance of the Question class
    final question = Question(category: 'some category');

    // Verify that the category field is set correctly
    expect(question.category, equals('some category'));

    // Verify that the socket field is set correctly
    expect(question.socket, isNotNull);
  });
}
