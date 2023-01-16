import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../api_functions/functions.dart';
import '../classes/own_question.dart';
import '../widgets/header.dart';
import 'create_quiz_page.dart';

///This class shows all custom quizzes created by the user
class MyQuizPage extends StatefulWidget {
  const MyQuizPage({super.key});

  @override
  State<MyQuizPage> createState() => _MyQuizPageState();
}

class _MyQuizPageState extends State<MyQuizPage> {
  ///data fetched from api
  late Future<dynamic> _futureQuizzes;

  ///list with converted data from api
  late List<String> _quizzesKeys = [];
  late List<dynamic> _quizzesValues = [];

  @override
  void initState() {
    super.initState();
    _futureQuizzes = getQuizzes();
  }

  ///edits a given quiz
  Future<void> _editQuiz(OwnQuiz quizData, String id) async {
    OwnQuiz quiz = await Get.to(() => const CreateQuizForm(), arguments: [
      quizData.title,
      quizData.category,
      quizData.difficulty,
      quizData.tags,
      quizData.questions,
      "Update!"
    ]);
    await editQuiz(id, quiz);
    setState(() {
      _futureQuizzes = getQuizzes();
    });
  }

  ///deletes the quiz with a given id
  Future<void> _deleteQuiz(String id) async {
    await deleteQuizByID(id);
    setState(() {
      _futureQuizzes = getQuizzes();
    });
  }

  ///widget that represents a quiz on the list of user's quizzes
  Widget quizListItemBar(
      {required double x,
      required double y,
      required OwnQuiz quiz,
      required String id}) {
    return SizedBox(
        width: 395 * x,
        height: 100 * y,
        child: Center(
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
                      onPressed: () async => {await _editQuiz(quiz, id)},
                      icon: const Icon(Icons.edit_outlined),
                      iconSize: 45 * y,
                      color: Colors.white),
                  IconButton(
                      onPressed: () async => {await _deleteQuiz(id)},
                      icon: const Icon(Icons.delete_forever_outlined),
                      iconSize: 45 * y,
                      color: Colors.white)
                ],
              )),
        ));
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
              body: FutureBuilder<dynamic>(
                  future: _futureQuizzes,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {}
                    if (snapshot.hasData) {
                      _quizzesKeys = snapshot.data.keys.toList();
                      _quizzesValues =
                          snapshot.data.values.toList().map((item) {
                        return OwnQuiz.fromJson(item as Map<String, dynamic>);
                      }).toList();
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                            height: 500 * y,
                            child: ListView.builder(
                                itemCount: _quizzesKeys.length,
                                itemBuilder: (context, index) {
                                  return quizListItemBar(
                                      x: x,
                                      y: y,
                                      quiz: _quizzesValues[index],
                                      id: _quizzesKeys[index]);
                                })),
                        Center(
                            child: ElevatedButton(
                                onPressed: () async {
                                  await Get.to(() => const CreateQuizForm(),
                                      arguments: [
                                        "",
                                        "Category",
                                        "easy",
                                        <String>[],
                                        <OwnQuestion>[],
                                        "Create!"
                                      ]);
                                  setState(() {
                                    _futureQuizzes = getQuizzes();
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.cyan,
                                    fixedSize: Size(280 * x, 96 * y),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(32.0 * y),
                                    )),
                                child: Text(
                                  'Add a quiz',
                                  style: TextStyle(
                                      fontSize: 30 * y, color: Colors.white),
                                )))
                      ],
                    );
                  }))),
    );
  }
}
