import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizly_app/widgets/header.dart';
import 'package:quizly_app/pages/category_page.dart';
import 'package:quizly_app/pages/question.dart';

class GameForm extends StatefulWidget {
  const GameForm({super.key});

  @override
  State<GameForm> createState() => _GameFormState();
}

class _GameFormState extends State<GameForm> {
  double _currentSliderValue = 5;
  bool selected = false;
  String name = 'Private';

  String _category = "Category";

  void _newCategory() async {
    _category = await Get.to(const CategoryPage());
    setState(() {
      _category = _category;
    });
  }

  Widget form(double x, double y) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
            width: 390 * x,
            height: 120 * y,
            child: Stack(children: <Widget>[
              Positioned(
                  left: 32 * x,
                  child: Container(
                      width: 324 * x,
                      height: 120 * y,
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
                top: 24 * y,
                left: 32 * y,
                width: 324 * x,
                height: 120 * y,
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
        SizedBox(
            width: 390 * x,
            height: 64 * y,
            child: Stack(children: <Widget>[
              Positioned(
                  left: 32,
                  child: Container(
                      width: 324 * x,
                      height: 64 * y,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        color: Colors.white,
                      ))),
              Positioned(
                  left: 32 * x,
                  width: 162 * x,
                  height: 64 * y,
                  top: 17 * y,
                  child: Text(
                    "Public",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Poppins',
                        fontSize: 30 * y,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  )),
              Positioned(
                  left: 194 * x,
                  width: 162 * x,
                  height: 64 * y,
                  top: 17 * y,
                  child: Text(
                    "Private",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Poppins',
                        fontSize: 30 * y,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  )),
              Positioned(
                left: 20 * x,
                width: 340 * x,
                height: 64 * y,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: SizedBox(
                      width: 195 * x,
                      height: 64 * y,
                      child: Stack(
                        children: <Widget>[
                          AnimatedPositioned(
                            width: 180 * x,
                            height: 64 * y,
                            left: selected ? 0 : 162,
                            duration: const Duration(seconds: 2),
                            curve: Curves.fastOutSlowIn,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected = !selected;
                                  if (selected) {
                                    name = 'Public';
                                  } else {
                                    name = "Private";
                                  }
                                });
                              },
                              child: Container(
                                color: Colors.cyan,
                                child: Center(
                                    child: Text(name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Poppins',
                                            fontSize: 30 * y,
                                            fontWeight: FontWeight.normal,
                                            height: 1))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ])),
        SizedBox(
            width: 390 * x,
            height: 64 * y,
            child: Stack(children: <Widget>[
              Positioned(
                  left: 32 * x,
                  child: Container(
                    width: 324 * x,
                    height: 64 * y,
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
                        fixedSize: Size(100 * x, 68 * y),
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
                  top: 16 * y,
                  child: Text(
                    _category,
                    style: TextStyle(fontSize: 25 * y, color: Colors.black),
                  )),
            ])),
        SizedBox(
          width: 390 * x,
          height: 110 * y,
          child: Stack(
            children: <Widget>[
              Positioned(
                  left: 32 * x,
                  child: Container(
                    width: 324 * x,
                    height: 110 * y,
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
                      Text('Max players: ${_currentSliderValue.toInt()}',
                          style:
                              TextStyle(fontSize: 20 * y, color: Colors.black)),
                      SliderTheme(
                          data: SliderThemeData(
                              trackHeight: 32 * y,
                              activeTrackColor: Colors.cyan,
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 16 * y),
                              thumbColor: Colors.cyan),
                          child: Slider(
                            value: _currentSliderValue,
                            min: 1,
                            max: 10,
                            divisions: 10,
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
        ElevatedButton(
            onPressed: () {
              Get.to(Question(
                category: _category,
              ));
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                fixedSize: Size(280 * x, 120 * y),
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
          preferredSize: Size.fromHeight(70 * y),
          child: Header(
            leftIcon: 'assets/images/profile.png',
            rightIcon: 'assets/images/settings.png',
            y: y,
          ),
        ),
        body: form(x, y),
      )),
    );
  }
}
