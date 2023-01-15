import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/auth.dart';
import '../classes/own_question.dart';
import '../widgets/header.dart';
import 'between_page.dart';
import 'create_quiz_page.dart';

class MyQuizPage extends StatefulWidget {
  MyQuizPage({super.key, required this.nick, this.uID = ""});

  var rng = Random();
  final String nick;
  final String uID;

  @override
  State<MyQuizPage> createState() => _MyQuizPageState();
}

class _MyQuizPageState extends State<MyQuizPage> {
  double _currentSliderValue = 4;
  late Future<List<String>> _futureQuizzesID;
  List<String> _quizzesID = [];

  @override
  void initState() {
    _futureQuizzesID = getQuizzesID();
    super.initState();
  }

  void _newQuiz() async {
    await Get.to(() => const CreateQuizForm(), arguments: [
      "",
      "Category",
      "easy",
      <String>[],
      <OwnQuestion>[],
      "Create!"
    ]);
  }

  void _editQuiz(OwnQuiz quizData, String id) async {
    OwnQuiz quiz = await Get.to(() => const CreateQuizForm(), arguments: [
      quizData.title,
      quizData.category,
      quizData.difficulty,
      quizData.tags,
      quizData.questions,
      "Update!"
    ]);
    setState(() {
      editQuiz(id, quiz);
    });
  }

  Widget quizListItemBar(
      {required double x, required double y, required String id}) {
    Future<OwnQuiz> futureQuiz = getQuizById(id);
    OwnQuiz quiz = OwnQuiz(
      title: '',
      category: 'Category',
      difficulty: '',
      tags: [],
      questions: [],
    );

    return FutureBuilder<OwnQuiz>(
      future: futureQuiz,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          quiz = snapshot.data!;
        }

        return SizedBox(
            width: 395 * x,
            height: 100 * y,
            child: Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300, elevation: 0),
                  onPressed: () {
                    Get.to(() => BetweenPage(
                          nick: widget.nick,
                          uID: widget.uID,
                          quizID: id,
                          maxPlayers: _currentSliderValue.toInt(),
                        ));
                  },
                  child: Container(
                      width: 370 * x,
                      height: 80 * y,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          color: Colors.cyan),
                      child: Row(
                        children: [
                          SizedBox(width: 10 * x),
                          Container(
                            width: 220 * x,
                            height: 60 * y,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                                color: Colors.white),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(children: [
                                  SizedBox(
                                    width: 10 * x,
                                  ),
                                  Text(
                                    quiz.title.length < 20
                                        ? quiz.title
                                        : "${quiz.title.substring(0, 17)}...",
                                    style: TextStyle(
                                        fontSize: 20 * y, color: Colors.black),
                                  ),
                                ])),
                          ),
                          SizedBox(width: 10 * x),
                          IconButton(
                              onPressed: () => {
                                    setState(() {
                                      _editQuiz(quiz, id);
                                    })
                                  },
                              icon: const Icon(Icons.edit_outlined),
                              iconSize: 45 * y,
                              color: Colors.white),
                          IconButton(
                              onPressed: () => {
                                    setState(() {
                                      _quizzesID.remove(id);
                                      deleteQuizByID(id);
                                    })
                                  },
                              icon: const Icon(Icons.delete_forever_outlined),
                              iconSize: 45 * y,
                              color: Colors.white)
                        ],
                      ))),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width / 411.42857142857144;
    double y = MediaQuery.of(context).size.height / 866.2857142857143;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
              backgroundColor: Colors.grey[300],
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(80 * y),
                child: Header(
                  leftIcon: 'assets/images/profile.png',
                  rightIcon: 'assets/images/settings.png',
                  y: y,
                ),
              ),
              body: FutureBuilder<List<String>>(
                  future: _futureQuizzesID,
                  builder: (context, snapshot) {
                    var childrenQuestions = <Widget>[];
                    void setup() {
                      childrenQuestions = [];
                      if (snapshot.hasData) {
                        _quizzesID = snapshot.data!;
                        for (int i = 0; i < _quizzesID.length; i++) {
                          childrenQuestions.add(
                              quizListItemBar(x: x, y: y, id: _quizzesID[i]));
                        }
                      }
                    }

                    setup();

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //const SizedBox(height: 20),
                        SizedBox(
                          width: 390 * x,
                          height: 84 * y,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                  left: 32 * x,
                                  child: Container(
                                    width: 324 * x,
                                    height: 84 * y,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                        ),
                                        color: Colors.white),
                                    child: SingleChildScrollView(
                                      child: Column(children: [
                                        Container(
                                          height: 7 * y,
                                        ),
                                        Text(
                                            'Max players: ${_currentSliderValue.toInt()}',
                                            style: TextStyle(
                                                fontSize: 20 * y,
                                                color: Colors.black)),
                                        SliderTheme(
                                            data: SliderThemeData(
                                                trackHeight: 24 * y,
                                                activeTrackColor: Colors.cyan,
                                                thumbShape:
                                                    RoundSliderThumbShape(
                                                        enabledThumbRadius:
                                                            18 * y),
                                                thumbColor: Colors.cyan),
                                            child: Slider(
                                              value: _currentSliderValue,
                                              min: 1,
                                              max: 10,
                                              divisions: 9,
                                              onChanged: (double value) {
                                                setState(() {
                                                  _currentSliderValue = value;
                                                });
                                              },
                                            )),
                                      ]),
                                    ),
                                  )),
                            ],
                          ),
                        ),

                        SizedBox(
                            height: 500 * y,
                            child: SingleChildScrollView(
                                child: Column(children: childrenQuestions))),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _newQuiz();
                                //_futureQuizzesID = getQuizzesID();
                                setup();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.cyan,
                                fixedSize: Size(280 * x, 96 * y),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0 * y),
                                )),
                            child: Text(
                              'Add a quiz',
                              style: TextStyle(
                                  fontSize: 30 * y, color: Colors.white),
                            ))
                        /**/
                      ],
                    );
                  }))),
    );
  }
}
