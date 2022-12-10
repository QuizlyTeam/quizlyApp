import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizly_app/widgets/header.dart';
import 'package:quizly_app/pages/score.dart';

class Question extends StatefulWidget {
  final IO.Socket socket = IO.io('http://10.0.2.2:8000/',
      IO.OptionBuilder().setTransports(['websocket']).build());
  final String category;
  Question({super.key, required this.category});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  String question = "";
  String tempQuestion = "";
  String ans1 = "";
  String ans2 = "";
  String ans3 = "";
  String ans4 = "";
  String tempAns1 = "";
  String tempAns2 = "";
  String tempAns3 = "";
  String tempAns4 = "";
  String correctAnswer = "";
  String tempCorrectAnswer = "";
  bool first = true;

  int totalScore = 0;

  double value = 1;
  int questionNumber = 1;
  bool clickedAnything = false;

  var normalColor = Colors.cyan;

  List<bool> wasClicked = [false, false, false, false];
  @override
  void initState() {
    super.initState();
    value = 1;

    String cat = widget.category.replaceFirst(r' & ', '_and_').toLowerCase();

    var quizOptions = {
      "name": "guest",
      "categories": cat,
      "max_players": 1,
      "limit": 3
    };
    widget.socket.emit("join", quizOptions);
    widget.socket.emit('question');
    widget.socket.on('question', (data) {
      if (first) {
        first = false;
        question = data['question'];
        data['answers'].shuffle();
        ans1 = data['answers'][0];
        ans2 = data['answers'][1];
        ans3 = data['answers'][2];
        ans4 = data['answers'][3];
        correctAnswer = data['answers'][0];
      } else {
        setState(() {
          tempQuestion = data['question'];
          data['answers'].shuffle();
          tempAns1 = data['answers'][0];
          tempAns2 = data['answers'][1];
          tempAns3 = data['answers'][2];
          tempAns4 = data['answers'][3];
          tempCorrectAnswer = data['answers'][0];
        });
      }
    });
    widget.socket.on('results', (data) {totalScore = data['guest'];});
    determinateIndicator();
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
      onPressed: clickedAnything && questionNumber<=10
          ? () {}
          : () {
              widget.socket.emit("answer", {"answer": answer, "time": 0});
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
      if (value <= 0) {
        if ( questionNumber == 3 ) {
          timer.cancel();
          Get.to(Score(score: totalScore));
        } else {
          setState(() {
            clickedAnything = false;
            wasClicked = [false, false, false, false];
            value = 1;
            questionNumber++;

            question = tempQuestion;
            ans1 = tempAns1;
            ans2 = tempAns2;
            ans3 = tempAns3;
            ans4 = tempAns4;
            correctAnswer = tempCorrectAnswer;
          });
        }
      } else {
        setState(() {
          value = value - 0.0000774;
        });
      }
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
