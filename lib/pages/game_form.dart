import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizly_app/pages/between_page.dart';
import 'package:quizly_app/widgets/header.dart';
import 'package:quizly_app/pages/category_page.dart';
import 'package:quizly_app/pages/tag_page.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

import '../auth/auth.dart';
import '../classes/own_question.dart';

/// Game form of the game. Gives three ways to start the game.
///
/// Contains three tabs of possible ways to start the game.
/// First - user can choose max number of players, quiz category, tags, number
/// of questions and questions' difficulty.
/// Second - user can input room ID and join already created game.
/// Third - if user is logged in, he will be able to chose one of his quiz and
/// play it.
class GameForm extends StatefulWidget {
  const GameForm({super.key, required this.nick, this.uID = ""});

  /// Player's nickname.
  final String nick;
  /// Player's database id.
  final String uID;

  @override
  State<GameForm> createState() => _GameFormState();
}

class _GameFormState extends State<GameForm> {
  double _currentSliderValue = 4; //max number of players
  double _numberOfQuestions = 10;
  int _selectedDifficulty = 0; //0-easy 1-medium 2-hard
  String room = ""; //room id

  var arr = ["easy", "medium", "hard"]; //array with difficulties

  String _category = "Category"; // chosen category
  List<String> _tags = [];

  late Future<dynamic> _futureQuizzes;
  late List<String> _quizzesKeys = [];
  late List<dynamic> _quizzesValues = [];

  @override
  void initState() {
    _futureQuizzes = getQuizzes();
    super.initState();
  }

  //gets quiz category
  void _newCategory() async {
    _category = await Get.to(() => const CategoryPage());
    setState(() {
      _category = _category;
    });
  }

  //get quiz tags
  void _newTags() async {
    _tags = await Get.to(() => const TagPage());
    setState(() {
      _tags = _tags;
    });
  }

  //body of custom game form
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
                          'Choose your',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 36 * y,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                        Text(
                          'game options:',
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
        /*
        Maximum number of players
         */
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
                        Text('Max players: ${_currentSliderValue.toInt()}',
                            style: TextStyle(
                                fontSize: 20 * y, color: Colors.black)),
                        SliderTheme(
                            data: SliderThemeData(
                                trackHeight: 24 * y,
                                activeTrackColor: Colors.cyan,
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 18 * y),
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
                          borderRadius: BorderRadius.circular(15.0),
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
                          borderRadius: BorderRadius.circular(15.0),
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
        Number of questions
         */
        SizedBox(
          width: 390 * x,
          height: 96 * y,
          child: Stack(
            children: <Widget>[
              Positioned(
                  left: 32 * x,
                  child: Container(
                    width: 324 * x,
                    height: 96 * y,
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
                        height: 6 * y,
                      ),
                      Text('Number of questions: ${_numberOfQuestions.toInt()}',
                          style:
                              TextStyle(fontSize: 20 * y, color: Colors.black)),
                      SliderTheme(
                          data: SliderThemeData(
                              trackHeight: 24 * y,
                              activeTrackColor: Colors.cyan,
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 18 * y),
                              thumbColor: Colors.cyan),
                          child: Slider(
                            value: _numberOfQuestions,
                            min: 5,
                            max: 20,
                            divisions: 3,
                            onChanged: (double value) {
                              setState(() {
                                _numberOfQuestions = value;
                              });
                            },
                          )),
                    ]),
                  )),
            ],
          ),
        ),
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
            onPressed: () => Get.to(BetweenPage(
                  category: _category,
                  tags: const [],
                  maxPlayers: _currentSliderValue.toInt(),
                  numOfQuestions: _numberOfQuestions.toInt(),
                  difficulty: arr[_selectedDifficulty],
                  nick: widget.nick,
                  uID: widget.uID,
                )),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                fixedSize: Size(280 * x, 96 * y),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                )),
            child: Text(
              'Play!',
              style: TextStyle(fontSize: 30 * y, color: Colors.white),
            ))
      ],
    );
  }

  //body of entering code
  Column enterCode(double x, double y) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: <Widget>[
            /*
            Background
             */
            Positioned(
              left: 12 * x,
              child: Container(
                width: 390 * x,
                height: 208 * y,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    color: Colors.white),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 20 * y,
                ),
                /*
                Nice information about destiny of text field below
                 */
                Text(
                  'Enter room ID:',
                  style: TextStyle(
                    fontSize: 36 * y,
                  ),
                ),
                Container(
                  height: 10 * y,
                ),
                SizedBox(
                  width: 390 * y,
                  /*
                  Place to enter room id
                   */
                  child: TextField(
                    onChanged: (value) {
                      room = value;
                    },
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ID',
                    ),
                    style: TextStyle(fontSize: 30 * y),
                  ),
                ),
                Container(
                  height: 80 * y,
                )
              ],
            ),
          ],
        ),
        /*
        PLay button, goes to question page
         */
        ElevatedButton(
            onPressed: () => Get.to(BetweenPage(
                  nick: widget.nick,
                  roomID: room,
                  uID: widget.uID,
                )),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                fixedSize: Size(280 * x, 96 * y),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                )),
            child: Text(
              'Play!',
              style: TextStyle(fontSize: 30 * y, color: Colors.white),
            ))
      ],
    );
  }

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
                  SizedBox(width: 35 * x),
                  IconButton(
                      onPressed: () => {
                            Get.to(() => BetweenPage(
                                  nick: widget.nick,
                                  uID: widget.uID,
                                  quizID: id,
                                  maxPlayers: _currentSliderValue.toInt(),
                                ))
                          },
                      icon: const Icon(Icons.play_arrow_rounded),
                      iconSize: 45 * y,
                      color: Colors.white)
                ],
              )),
        ));
  }

  createdQuizzes(double x, double y) {
    return FutureBuilder<dynamic>(
        future: _futureQuizzes,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {}
          if (snapshot.hasData) {
            _quizzesKeys = snapshot.data.keys.toList();
            _quizzesValues = snapshot.data.values.toList().map((item) {
              return OwnQuiz.fromJson(item as Map<String, dynamic>);
            }).toList();
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
                                      fontSize: 20 * y, color: Colors.black)),
                              SliderTheme(
                                  data: SliderThemeData(
                                      trackHeight: 24 * y,
                                      activeTrackColor: Colors.cyan,
                                      thumbShape: RoundSliderThumbShape(
                                          enabledThumbRadius: 18 * y),
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
                height: 550 * y,
                child: ListView.builder(
                    itemCount: _quizzesKeys.length,
                    itemBuilder: (context, index) {
                      return quizListItemBar(
                          x: x,
                          y: y,
                          quiz: _quizzesValues[index],
                          id: _quizzesKeys[index]);
                    }),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    //scaling factors
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
              body: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    /*
                    Various game form forms
                     */
                    TabBar(
                      indicatorColor: Colors.cyan,
                      labelStyle: TextStyle(
                        fontSize: 20 * y,
                        fontWeight: FontWeight.bold,
                      ),
                      tabs: [
                        Tab(
                          child: Text("Custom",
                              style: TextStyle(
                                  fontSize: 20 * y, color: Colors.black)),
                        ),
                        Tab(
                          child: Text("Enter Code",
                              style: TextStyle(
                                  fontSize: 20 * y, color: Colors.black)),
                        ),
                        Tab(
                          child: Text("My quizzes",
                              style: TextStyle(
                                  fontSize: 20 * y, color: Colors.black)),
                        ),
                      ],
                    ),
                    Expanded(
                      /*
                      Tabs implementation
                       */
                        child: TabBarView(
                        children: [
                          customQuiz(x, y),
                          enterCode(x, y),
                          createdQuizzes(x, y),
                        ],
                    )),
                  ],
                ),
              )
          )
      ),
    );
  }
}
