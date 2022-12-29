import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizly_app/widgets/header.dart';
import 'package:quizly_app/pages/category_page.dart';
import 'package:quizly_app/pages/question.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

class GameForm extends StatefulWidget {
  const GameForm({super.key});

  @override
  State<GameForm> createState() => _GameFormState();
}

class _GameFormState extends State<GameForm> {
  double _currentSliderValue = 4;
  double _numberOfQuestions = 10;
  int _selectedPrivacy = 1;
  int _selectedDifficulty = 0;
  String name = 'Private';

  String _category = "Category";
  List<String> _tags = ["Tags"];

  void _newCategory() async {
    _category = await Get.to(const CategoryPage());
    setState(() {
      _category = _category;
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
            ])
        ),
        /*
        Game privacy options
         */
        SizedBox(
            width: 390 * x,
            height: 44 * y,
            child: Stack(children: <Widget>[
              Positioned(
                left: 32 * x,
                child: FlutterToggleTab(
                  width: 83 * x,
                  height: 44 * y,
                  borderRadius: 15,
                  selectedBackgroundColors: const [Colors.cyan],
                  unSelectedBackgroundColors: const [Colors.white],
                  selectedIndex: _selectedPrivacy,
                  selectedTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 30 * y,
                      fontWeight: FontWeight.w600),
                  unSelectedTextStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 30 * y,
                      fontWeight: FontWeight.normal),
                  labels: const ["Public", "Private"],
                  selectedLabelIndex: (index) {
                    setState(() {
                      _selectedPrivacy = index;
                    });
                  },
                ),
              )
            ],)

        ),
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
                    child: Column(children: [
                      Container(
                        height: 7 * y,
                      ),
                      Text('Max players: ${_currentSliderValue.toInt()}',
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
            ])
        ),
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
                  child: ElevatedButton(
                    onPressed: (){},
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
                    _tags[0],
                    style: TextStyle(fontSize: 25 * y, color: Colors.black),
                  )),
            ])
        ),
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
                        height: 16 * y,
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
            child: Stack(children: <Widget>[
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
                          style:
                          TextStyle(fontSize: 20 * y, color: Colors.black)),
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
            ],)

        ),
        /*
        Play button
         */
        ElevatedButton(
            onPressed: () {
              Get.to(Question(
                category: _category,
              ));
            },
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

  Widget form(double x, double y) {
    return customQuiz(x, y);
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
              child: Column(
                children: [
                  Header(
                    leftIcon: 'assets/images/profile.png',
                    rightIcon: 'assets/images/settings.png',
                    y: y,
                  ),
                ],
              )
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
                    tabs: const [
                      Tab(text: 'Custom game'),
                      Tab(text: 'My quizzes'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        form(x, y),
                        const Text('Tab 2 content'),
                      ],
                    ),
                  ),
                ],
              ),
            )
      )),
    );
  }
}
