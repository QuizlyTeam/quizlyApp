import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizly_app/auth/auth.dart';
import 'package:quizly_app/widgets/header.dart';
import 'package:quizly_app/pages/category_page.dart';
import 'package:quizly_app/pages/tag_page.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:quizly_app/pages/create_question_page.dart';

import '../classes/own_question.dart';

class CreateQuizForm extends StatefulWidget {
  const CreateQuizForm({super.key});

  @override
  State<CreateQuizForm> createState() => _CreateQuizFormState();
}

class _CreateQuizFormState extends State<CreateQuizForm> {
  var argumentData = Get.arguments;
  late String _title = "";
  int _selectedDifficulty = 0;
  var arr = ["easy", "medium", "hard"];
  List<OwnQuestion> _questions = [];
  String _category = "Category";
  List<String> _tags = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _title = argumentData[0];
    _selectedDifficulty = arr.indexOf(argumentData[2]);
    _questions = argumentData[4];
    _category = argumentData[1];
    _tags = argumentData[3];
    super.initState();
  }

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
    OwnQuestion question =
        await Get.to(() => const CreateQuestionForm(), arguments: [
      "",
      "",
      ["", "", ""]
    ]);
    setState(() {
      _questions.add(question);
    });
  }

  void _editQuestion(OwnQuestion questionData) async {
    OwnQuestion question =
        await Get.to(() => const CreateQuestionForm(), arguments: [
      questionData.question,
      questionData.correct_answer,
      questionData.inCorrectanswers
    ]);
    setState(() {
      int indeks = _questions.indexOf(questionData);
      _questions[indeks] = question;
    });
  }

  Widget questionListItemBar(
      {required double x, required double y, required OwnQuestion question}) {
    return SizedBox(
      width: 390 * x,
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
                            (question.question?.length ?? 0) < 20
                                ? "${question.question}"
                                : "${question.question?.substring(0, 17)}...",
                            style: TextStyle(
                                fontSize: 20 * y, color: Colors.black),
                          ),
                        ])),
                  ),
                  SizedBox(width: 10 * x),
                  IconButton(
                      onPressed: () => {
                            setState(() {
                              _editQuestion(question);
                            })
                          },
                      icon: const Icon(Icons.edit_outlined),
                      iconSize: 45 * y,
                      color: Colors.white),
                  IconButton(
                      onPressed: () => {
                            setState(() {
                              _questions.remove(question);
                            })
                          },
                      icon: const Icon(Icons.delete_forever_outlined),
                      iconSize: 45 * y,
                      color: Colors.white)
                ],
              ))),
    );
  }

  Form customQuiz(double x, double y) {
    return Form(
        key: _formKey,
        child: Column(
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
            Container(
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
                    style: TextStyle(
                        fontSize: 20 * y, color: Colors.black, height: 0.75)),
                TextFormField(
                  validator: (value) =>
                      RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value!)
                          ? null
                          : "Enter a valid title",
                  initialValue: _title,
                  onChanged: (value) {
                    _title = value;
                  },
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(height: 0.05 * y),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(36.84 * y),
                        borderSide: BorderSide.none),
                    hintText: "Title",
                  ),
                ),
              ]),
            ),

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
                              borderRadius: BorderRadius.circular(15.0 * x),
                            )),
                        child: Text(
                          'Pick',
                          style:
                              TextStyle(fontSize: 30 * x, color: Colors.black),
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
                              borderRadius: BorderRadius.circular(15.0 * x),
                            )),
                        child: Text(
                          'Pick',
                          style:
                              TextStyle(fontSize: 30 * x, color: Colors.black),
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
                  if (_formKey.currentState!.validate()) {
                    createQuiz(_title, _category, arr[_selectedDifficulty],
                        _tags, _questions);
                    /*ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    behavior: SnackBarBehavior.floating,
                    elevation: 3,
                    content: Text("Quiz has been created!"),
                  ));*/
                    Get.back(
                        result: OwnQuiz(
                            title: _title,
                            category: _category,
                            difficulty: arr[_selectedDifficulty],
                            tags: _tags,
                            questions: _questions));
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    fixedSize: Size(280 * x, 80 * y),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0 * y),
                    )),
                child: Text(
                  'Create!',
                  style: TextStyle(fontSize: 30 * y, color: Colors.white),
                ))
          ],
        ));
  }

  createdQuestions(double x, double y) {
    var childrenQuestions = <Widget>[];
    for (int i = 0; i < _questions.length; i++) {
      childrenQuestions
          .add(questionListItemBar(x: x, y: y, question: _questions[i]));
    }

    return Column(
      children: [
        SizedBox(
            height: 550 * y,
            child: SingleChildScrollView(
                child: Column(children: childrenQuestions))),
        ElevatedButton(
            onPressed: () {
              _newQuestion();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                fixedSize: Size(280 * x, 96 * y),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0 * y),
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
              body: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      indicatorColor: Colors.cyan,
                      labelStyle: TextStyle(
                        fontSize: 24 * y,
                        fontWeight: FontWeight.bold,
                      ),
                      tabs:  [
                        Tab(child: Text("Quiz",style: TextStyle(fontSize: 20*y,color: Colors.black)),),
                        Tab(child: Text("Questions",style: TextStyle(fontSize: 20*y,color: Colors.black)),),
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
