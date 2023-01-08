import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizly_app/pages/question.dart';
import 'package:mockito/mockito.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MockSocket extends Mock implements IO.Socket {}

void main() {
  testWidgets("Check if text is shown properly", (widgetTester) async {
    final socket = MockSocket();
    await widgetTester.pumpWidget(MaterialApp(home: Question(socket: socket, numOfQuestions: 5, player: "user")));
  });
}
