import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:get/get.dart';
import 'package:quizly_app/widgets/header.dart';

class Question extends StatefulWidget {
  final String question;
  final String ans1;
  final String ans2;
  final String ans3;
  final String ans4;
  final String correctAnswer;
  const Question(
      {super.key,
      required this.question,
      required this.ans1,
      required this.ans2,
      required this.ans3,
      required this.ans4,
      required this.correctAnswer});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  double value = 1;
  bool clickedAnything = false;
  var normalColor = Colors.cyan;
  List<bool> wasClicked = [false, false, false, false];
  @override
  void initState() {
    super.initState();
    value = 1;

    determinateIndicator();

    //setState(() {});
  }

  Widget answerButton(String answer, int index) {
    if (answer == widget.correctAnswer && clickedAnything) {
      normalColor = Colors.green;
    } else if (answer != widget.correctAnswer && wasClicked.elementAt(index)) {
      normalColor = Colors.red;
    } else {
      normalColor = Colors.cyan;
    }

    return ElevatedButton(
      onPressed: clickedAnything
          ? () {}
          : () {
              if (answer == widget.correctAnswer) {
                setState(() {
                  clickedAnything = true;
                  //  wasClicked[index]= true;
                  // normalColor = Colors.green;
                });
              } else {
                setState(() {
                  clickedAnything = true;
                  wasClicked[index] = true;

                  //   normalColor = Colors.red;
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
        style: const TextStyle(fontSize: 30, color: Colors.black),
      ),
    );
  }

  void determinateIndicator() {
    Timer.periodic(const Duration(milliseconds: 1), (Timer timer) {
      setState(() {
        if (value <= 0) {
          timer.cancel();
        } else {
          value = value - 0.00015;
        }
      });
    });
  }

  Widget bodyOfQuestion() {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          "Pytanie 1:",
          style: TextStyle(
              fontSize: 50,
              height: 1,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 20),
        SizedBox(
          child: Text(
            widget.question,
            textAlign: TextAlign.center,
            style: const TextStyle(height: 1.2, fontSize: 40),
          ),
        ),
        const SizedBox(height: 30),
        const Image(
          image: AssetImage('assets/images/flag.png'),
          height: 200,
        ),
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
            answerButton(widget.ans1, 0),
            answerButton(widget.ans2, 1)
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            answerButton(widget.ans3, 2),
            answerButton(widget.ans4, 3)
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
