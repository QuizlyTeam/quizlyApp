import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:quizly_app/pages/between_page.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizly_app/widgets/header.dart';
import 'package:quizly_app/pages/score.dart';

import '../services/socket_config.dart';

/// Responsible for actual game page.
///
/// Takes questions from contentapi and shows it to user. Takes user's input and
/// sends it back to API giving user information if his answer was either good
/// or bad. After ended game goes to [Score].
//ignore: must_be_immutable
class Question extends StatefulWidget {
  /// Socket with which a player connects after choosing game options. Same as
  /// in [BetweenPage]
  IO.Socket socket = IO.io(
      config["ip"], IO.OptionBuilder().setTransports(['websocket']).build());

  /// Chosen by player length of quiz.
  final int numOfQuestions;
  /// User's nickname.
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
  String question = ""; //current question
  String tempQuestion = ""; //real question, in case of api being to fast
  //current answers
  String ans1 = "";
  String ans2 = "";
  String ans3 = "";
  String ans4 = "";
  //answers to be
  String tempAns1 = "";
  String tempAns2 = "";
  String tempAns3 = "";
  String tempAns4 = "";
  String correctAnswer = ""; //as names goes
  String tempCorrectAnswer = ""; //just in case
  bool first = true; //flag if it's first question

  Map totalScore = {}; //score of all players

  double value = 1; //timer value
  int questionNumber = 1; //number of questions
  bool clickedAnything = false; //tells if answer was submited

  var normalColor = Colors.cyan; //app color

  //to time measurement
  final stopwatch = Stopwatch();

  bool ready = false; //time ready to restard
  bool emittedProperAnswer = false;

  List<bool> wasClicked = [false, false, false, false];
  @override
  void initState() {
    super.initState();
    value = 1; //preparing timer

    //getting question
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

    //getting proper answer
    widget.socket.on("answer", (data) {
      correctAnswer = data;
      emittedProperAnswer = true;
    });

    //getting results
    widget.socket.on("results", (data) {
      totalScore = data;
      widget.socket.disconnect();
      Get.to(Score(
        score: totalScore,
        player: widget.player,
      ));
    });

    //starting timer
    stopwatch.start();
    determinateIndicator();
  }

  //shows properly all buttons
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
        //get answer and time taken for thinking
              double time = stopwatch.elapsedMilliseconds / 1000;
              time = time > 12 ? 12 : time;
              widget.socket.emit("answer", {"answer": answer, "time": time});

              //blocking resending answer
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

  //describes timer behaviour
  void determinateIndicator() {
    Timer.periodic(const Duration(milliseconds: 1), (Timer timer) {
      if (value <= 0) {
          setState(() {
            if (ready) {
              //reset page with proper question
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
      } else {
        //take time
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
        /*
        Title
         */
        Text(
          "Question $questionNumber:",
          style: TextStyle(
              fontSize: 50 * y,
              height: 1,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        SizedBox(height: 25 * y),
        /*
        Question
         */
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
        /*
        Timer
         */
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
        /*
        Buttons
         */
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
  //destructs widget
    widget.socket.close();
  }

  @override
  Widget build(BuildContext context) {
    //scaling factors
    double x = MediaQuery.of(context).size.width / 411.42857142857144;
    double y = MediaQuery.of(context).size.height / 866.2857142857143;
    //blocked returning
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
