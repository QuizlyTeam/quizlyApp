import 'package:flutter_test/flutter_test.dart';
import 'package:quizly_app/pages/question.dart';

void main() {
  test('Question test', () {
    // Create an instance of the Question class
    final question = Question(
      category: 'some category',
      tags: const ['1700\'s'],
      maxPlayers: 1,
      numOfQuestions: 10,
      difficulty: 'hard',
      private: true,
    );

    // Verify that the category field is set correctly
    expect(question.category, equals('some category'));
    expect(question.tags, equals(['1700\'s']));
    expect(question.maxPlayers, equals(1));
    expect(question.numOfQuestions, equals(10));
    expect(question.difficulty, equals('hard'));
    expect(question.private, equals(true));

    // Verify that the socket field is set correctly
    expect(question.socket, isNotNull);
  });
}
