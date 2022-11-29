import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
//import 'package:get/get.dart';
import 'package:quizly_app/widgets/header.dart';

class Question extends StatefulWidget {
  final IO.Socket socket = IO.io('http://10.0.2.2:8000/',
      IO.OptionBuilder().setTransports(['websocket']).build());

  Question({super.key});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  String question = "";
  String ans1 = "";
  String ans2 = "";
  String ans3 = "";
  String ans4 = "";
  String correctAnswer = "";

  double value = 1;
  int questionNumber = 1;
  bool clickedAnything = false;

  var normalColor = Colors.cyan;

  List<bool> wasClicked = [false, false, false, false];
  @override
  void initState() {
    super.initState();
    value = 1;
    var quizOptions = {
      "name": "guest",
      "categories": "arts_and_literature",
      "max_players": 1
    };
    widget.socket.emit("join", quizOptions);
    widget.socket.emit('question');
    widget.socket.on('question', (data) {
          question = data['question'];
          ans1 = data['answers'][0];
          ans2 = data['answers'][1];
          ans3 = data['answers'][2];
          ans4 = data['answers'][3];
          correctAnswer = data['answers'][0];
    });
    determinateIndicator();

    //setState(() {});
  }

  Widget answerButton(String answer, int index) {
    if (answer == correctAnswer && clickedAnything) {
      normalColor = Colors.green;
    } else if (answer != correctAnswer && wasClicked.elementAt(index)) {
      normalColor = Colors.red;
    } else {
      normalColor = Colors.cyan;
    }

    return ElevatedButton(
      onPressed: clickedAnything
          ? () {}
          : () async {
              var answers = ["A","B","C","D"];
              widget.socket.emit("answer", {"answer": answers[index], "time": 0});
              widget.socket.on("answer", (data) {correctAnswer = data;});
              if (answer == correctAnswer) {
                setState(() {
                  clickedAnything = true;
                  //  wasClicked[index]= true;
                  // normalColor = Colors.green;
                });
              } else {
                setState(() {
                  clickedAnything = true;
                  wasClicked[index] = true;

                  // normalColor = Colors.red;
                });
              }

              await Future.delayed(Duration(seconds: (value*18).toInt()));
              clickedAnything = false;
              wasClicked[index] = false;
              setState(() {
                widget.socket.emit('question');
                widget.socket.on('question', (data) {
                  question = data['question'];
                  ans1 = data['answers'][0];
                  ans2 = data['answers'][1];
                  ans3 = data['answers'][2];
                  ans4 = data['answers'][3];
                  questionNumber++;
                  value = 1;
                });
              });
            },
      style: ElevatedButton.styleFrom(
          backgroundColor: normalColor,
          fixedSize: const Size(190, 120),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          )),
      child: Text(
        answer,
        style: const TextStyle(fontSize: 20, color: Colors.black),
      ),
    );
  }

  void determinateIndicator() {
    Timer.periodic(const Duration(milliseconds: 1), (Timer timer) {
      setState(() {
        if (value <= 0) {
          timer.cancel();
        } else {
          value = value - 0.0000555;
        }
      });
    });
  }

  Widget bodyOfQuestion() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          "Question $questionNumber:",
          style: const TextStyle(
              fontSize: 50,
              height: 1,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 20),
        SizedBox(
          child: Text(
            question,
            textAlign: TextAlign.center,
            style: const TextStyle(height: 1.2, fontSize: 30),
          ),
        ),
        const SizedBox(height: 30),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
            width: 350,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey.shade300,
                color: Colors.cyan,
                minHeight: 20,
                value: value,

                //   value: controller.value,
              ),
            )),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            answerButton(ans1, 0),
            answerButton(ans2, 1)
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            answerButton(ans3, 2),
            answerButton(ans4, 3)
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: Header(
                  leftIcon: 'assets/images/back.png',
                  rightIcon: 'assets/images/settings.png'),
            ),
            body: SingleChildScrollView(
              child: bodyOfQuestion(),
            ),
          ),
        ));
  }
}
