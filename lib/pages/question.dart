import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizly_app/widgets/header.dart';
import 'package:quizly_app/pages/score.dart';

import '../services/socket_config.dart';

//ignore: must_be_immutable
class Question extends StatefulWidget {
  IO.Socket socket = IO.io(
      config["ip"], IO.OptionBuilder().setTransports(['websocket']).build());

  final int numOfQuestions;
  final String player;

  Question(
      {super.key,
      required this.socket,
      required this.numOfQuestions,
      required this.player});

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

  Map totalScore = {};

  double value = 1;
  int questionNumber = 1;
  bool clickedAnything = false;

  var normalColor = Colors.cyan;

  //to time measurement
  final stopwatch = Stopwatch();

  bool ready = false;
  bool emittedProperAnswer = false;

  List<bool> wasClicked = [false, false, false, false];
  @override
  void initState() {
    super.initState();
    value = 1;

    widget.socket.on('question', (data) {
      ready = true;
      stopwatch.reset();
      emittedProperAnswer = false;
      if (first) {
        first = false;
        question = data['question'];
        data['answers'].shuffle();
        ans1 = data['answers'][0];
        ans2 = data['answers'][1];
        ans3 = data['answers'][2];
        ans4 = data['answers'][3];
        correctAnswer = "";
      } else {
        setState(() {
          tempQuestion = data['question'];
          data['answers'].shuffle();
          tempAns1 = data['answers'][0];
          tempAns2 = data['answers'][1];
          tempAns3 = data['answers'][2];
          tempAns4 = data['answers'][3];
          tempCorrectAnswer = "";
        });
      }
    });

    widget.socket.on("answer", (data) {
      correctAnswer = data;
      emittedProperAnswer = true;
    });

    widget.socket.on("results", (data) {
      totalScore = data;
      widget.socket.disconnect();
      Get.to(Score(
        score: totalScore,
        player: widget.player,
      ));
    });

    stopwatch.start();
    determinateIndicator();
  }

  Widget answerButton(String answer, int index, double x, double y) {
    if (answer == correctAnswer && clickedAnything) {
      setState(() {
        normalColor = Colors.green;
      });
    } else if (answer != correctAnswer && wasClicked[index]) {
      setState(() {
        normalColor = Colors.red;
      });
    } else if (answer == correctAnswer && emittedProperAnswer) {
      setState(() {
        normalColor = Colors.yellow;
      });
    } else {
      setState(() {
        normalColor = Colors.cyan;
      });
    }

    return ElevatedButton(
      onPressed: clickedAnything
          ? () {}
          : () {
              double time = stopwatch.elapsedMilliseconds / 1000;
              time = time > 12 ? 12 : time;
              widget.socket.emit("answer", {"answer": answer, "time": time});

              if (answer == correctAnswer) {
                setState(() {
                  clickedAnything = true;
                });
              } else {
                setState(() {
                  wasClicked[index] = true;
                  clickedAnything = true;
                });
              }
            },
      style: ElevatedButton.styleFrom(
          backgroundColor: normalColor,
          fixedSize: Size(190 * x, 160 * y),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          )),
      child: Text(
        answer,
        style: TextStyle(fontSize: 30 * y, color: Colors.black),
      ),
    );
  }

  void determinateIndicator() {
    Timer.periodic(const Duration(milliseconds: 1), (Timer timer) {
      if (value <= 0) {
        if (questionNumber == widget.numOfQuestions) {
          timer.cancel();
        } else {
          setState(() {
            if (ready) {
              value = 1;

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
            }
          });
        }
      } else {
        setState(() {
          if (ready) {
            var elapsed = stopwatch.elapsedMilliseconds;
            if (elapsed >= 12000) {
              ready = false;
            }
            value = 1 - 1 / 12000 * elapsed;
          }
        });
      }
    });
  }

  Widget bodyOfQuestion(double x, double y) {
    return Column(
      children: [
        SizedBox(height: 30 * y),
        Text(
          "Question $questionNumber:",
          style: TextStyle(
              fontSize: 50 * y,
              height: 1,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        SizedBox(height: 25 * y),
        SizedBox(
          height: 110 * y,
          child: AutoSizeText(
            question,
            textAlign: TextAlign.center,
            style: TextStyle(height: 1.2, fontSize: 30 * y),
            maxLines: 3,
          ),
        ),
        SizedBox(height: 30 * y),
        SizedBox(
            width: 350 * x,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey.shade300,
                color: Colors.cyan,
                minHeight: 50 * y,
                value: value,

                //   value: controller.value,
              ),
            )),
        SizedBox(
          height: 50 * y,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [answerButton(ans1, 0, x, y), answerButton(ans2, 1, x, y)],
        ),
        SizedBox(
          height: 30 * y,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [answerButton(ans3, 2, x, y), answerButton(ans4, 3, x, y)],
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();

    widget.socket.close();
  }

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width / 411.42857142857144;
    double y = MediaQuery.of(context).size.height / 866.2857142857143;
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.grey[300],
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(70 * y),
                  child: Header(
                    leftIcon: 'assets/images/profile.png',
                    rightIcon: 'assets/images/settings.png',
                    y: y,
                  ),
                ),
                body: SingleChildScrollView(
                  child: bodyOfQuestion(x, y),
                ),
              ),
            )));
  }
}
