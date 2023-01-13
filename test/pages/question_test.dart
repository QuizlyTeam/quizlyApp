import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:quizly_app/pages/question.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

@GenerateMocks([IO.Socket])
void main() {
  test("Check if text is shown properly", () {
    IO.Socket socket =
        IO.io("x", IO.OptionBuilder().setTransports(['websocket']).build());

    int number = 5;
    String nick = "Michał";

    Question question =
        Question(socket: socket, numOfQuestions: number, player: nick);

    expect(question.socket, socket);
    expect(question.numOfQuestions, number);
    expect(question.player, nick);
  });
}
