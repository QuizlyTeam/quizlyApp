
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizly_app/auth/auth.dart';
import 'package:quizly_app/widgets/header.dart';
import 'package:quizly_app/pages/category_page.dart';
import 'package:quizly_app/pages/tag_page.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:quizly_app/widgets/list_item_bar.dart';
import 'package:quizly_app/pages/create_question_page.dart';

import '../classes/own_question.dart';

List<OwnQuestion> _questions = [];

class QuestionListItemBar extends ListItemBar {
  final OwnQuestion question;

  const QuestionListItemBar(
      {super.key, required super.x, required super.y, required super.title, required this.question});
  @override
  edit() {
  }

  @override
  delete() {
      _questions.remove(question);
  }
}

class CreateQuizForm extends StatefulWidget {
  const CreateQuizForm({super.key});

  @override
  State<CreateQuizForm> createState() => _CreateQuizFormState();
}

class _CreateQuizFormState extends State<CreateQuizForm> {
  late String _title = "";
  int _selectedDifficulty = 0;
  var arr = ["easy", "medium", "hard"];
  //List<Question> _questions = [];

  String _category = "Category";
  List<String> _tags = [];

  void _newCategory() async {
    _category = await Get.to(const CategoryPage());
    setState(() {
      _category = _category;
    });
  }

  void _newTags() async {
    _tags = await Get.to(const TagPage());
    setState(() {
      _tags = _tags;
    });
  }

  void _newQuestion() async {
    OwnQuestion question = await Get.to(() => const CreateQuestionForm());
    setState(() {
      _questions.add(question);

    });
  }

  Column customQuiz(double x, double y) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        /*
        Game options
         */
        SizedBox(
            width: 390 * x,
            height: 80 * y,
            child: Stack(children: <Widget>[
              Positioned(
                  left: 32 * x,
                  child: Container(
                      width: 324 * x,
                      height: 80 * y,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35),
                        ),
                        color: Colors.white,
                      ))),
              Positioned(
                top: 8 * y,
                left: 32 * y,
                width: 324 * x,
                height: 80 * y,
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Create your',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 36 * y,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                        Text(
                          'quiz:',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 36 * y,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        )
                      ]),
                ),
              )
            ])),
        SizedBox(
            width: 324 * x,
            height: 100 * y,
            child: Stack(children: [
              Positioned(
                  child: Container(
                width: 324 * x,
                height: 100 * y,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    color: Colors.white),
                child: Column(children: [
                  Container(
                    height: 7 * y,
                  ),
                  Text('Title:',
                      style: TextStyle(fontSize: 20 * y, color: Colors.black)),
                  TextField(
                    onChanged: (value) {
                      _title = value;
                    },
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(36.84 * y),
                          borderSide: BorderSide.none),
                      hintText: "Title",
                    ),
                  ),
                ]),
              )),
            ])),
        /*
        Category
         */
        SizedBox(
            width: 390 * x,
            height: 48 * y,
            child: Stack(children: <Widget>[
              Positioned(
                  left: 32 * x,
                  child: Container(
                    width: 324 * x,
                    height: 48 * y,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        color: Colors.white),
                  )),
              Positioned(
                  left: 258 * x,
                  top: -3 * y,
                  child: ElevatedButton(
                    onPressed: _newCategory,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan,
                        fixedSize: Size(100 * x, 50 * y),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0*x),
                        )),
                    child: Text(
                      'Pick',
                      style: TextStyle(fontSize: 30 * x, color: Colors.black),
                    ),
                  )),
              Positioned(
                  left: 48 * x,
                  top: 8 * y,
                  child: Text(
                    _category,
                    style: TextStyle(fontSize: 25 * y, color: Colors.black),
                  )),
            ])),
        /*
        Tags
         */
        SizedBox(
            width: 390 * x,
            height: 48 * y,
            child: Stack(children: <Widget>[
              Positioned(
                  left: 32 * x,
                  child: Container(
                    width: 324 * x,
                    height: 48 * y,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        color: Colors.white),
                  )),
              Positioned(
                  left: 258 * x,
                  top: -3 * y,
                  child: ElevatedButton(
                    onPressed: _newTags,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan,
                        fixedSize: Size(100 * x, 50 * y),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0*x),
                        )),
                    child: Text(
                      'Pick',
                      style: TextStyle(fontSize: 30 * x, color: Colors.black),
                    ),
                  )),
              Positioned(
                  left: 48 * x,
                  top: 8 * y,
                  child: Text(
                    (_tags.isEmpty
                        ? '0 tags selected'
                        : '${_tags.length} tags selected'),
                    style: TextStyle(fontSize: 25 * y, color: Colors.black),
                  )),
            ])),
        /*
        Difficulty
         */
        SizedBox(
            width: 390 * x,
            height: 72 * y,
            child: Stack(
              children: <Widget>[
                Positioned(
                    left: 32 * x,
                    child: Container(
                      width: 324 * x,
                      height: 72 * y,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          color: Colors.white),
                      child: Column(children: [
                        Container(
                          height: 7 * y,
                        ),
                        Text('Difficulty level:',
                            style: TextStyle(
                                fontSize: 20 * y, color: Colors.black)),
                        FlutterToggleTab(
                          width: 72 * x,
                          height: 32 * y,
                          borderRadius: 5,
                          selectedBackgroundColors: const [Colors.cyan],
                          unSelectedBackgroundColors: const [Colors.white],
                          selectedIndex: _selectedDifficulty,
                          selectedTextStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 24 * y,
                              fontWeight: FontWeight.w600),
                          unSelectedTextStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 24 * y,
                              fontWeight: FontWeight.normal),
                          labels: const ["Easy", "Medium", "Hard"],
                          selectedLabelIndex: (index) {
                            setState(() {
                              _selectedDifficulty = index;
                            });
                          },
                        ),
                        Container(
                          height: 7 * y,
                        ),
                      ]),
                    )),
              ],
            )),
        /*
        Play button
         */
        ElevatedButton(
            onPressed: () {

                createQuiz(_title, _category, arr[_selectedDifficulty], _tags, _questions);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                fixedSize: Size(280 * x, 80 * y),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0*y),
                )),
            child: Text(
              'Create!',
              style: TextStyle(fontSize: 30 * y, color: Colors.white),
            ))
      ],
    );
  }

  createdQuestions(double x, double y) {
    var childrenQuestions = <Widget>[];
    for(int i = 0; i < _questions.length; i++){
      childrenQuestions.add(QuestionListItemBar(x: x, y: y, title: "Example question ${i+1}", question: _questions[i]));
    }

    return Column(
      children: [
        SizedBox(
            height: 550 * y,
            child: SingleChildScrollView(
                child: Column(children: childrenQuestions
            ))),
        ElevatedButton(
            onPressed: () {
              _newQuestion();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                fixedSize: Size(280 * x, 96 * y),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0*y),
                )),
            child: Text(
              'Add a question',
              style: TextStyle(fontSize: 30 * y, color: Colors.white),
            ))
      ],
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
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.grey[300],
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(80 * y),
                child: Header(
                  leftIcon: 'assets/images/profile.png',
                  rightIcon: 'assets/images/settings.png',
                  y: y,
                ),
              ),
              body:
              DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      indicatorColor: Colors.cyan,
                      labelStyle: TextStyle(
                        fontSize: 24 * y,
                        fontWeight: FontWeight.bold,
                      ),
                      tabs: const [
                        Tab(text: 'Quiz'),
                        Tab(text: 'Questions'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          customQuiz(x, y),
                          createdQuestions(x, y),
                        ],
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}
