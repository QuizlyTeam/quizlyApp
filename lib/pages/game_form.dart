import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizly_app/widgets/header.dart';
import 'package:quizly_app/pages/category_page.dart';

class GameForm extends StatelessWidget {
  const GameForm({super.key});

  Widget form() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
            width: 390,
            height: 120,
            child: Stack(children: <Widget>[
              Positioned(
                  left: 32,
                  child: Container(
                      width: 324,
                      height: 120,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35),
                        ),
                        color: Colors.white,
                      )
                  )
              ),
              Positioned(
                top: 24,
                left: 32,
                width: 324,
                height: 120,
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text(
                          'Choose your',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 36,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                        Text(
                          'game options:',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 36,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        )
                      ]),
                ),
              )
            ]
            )
        ),
        SizedBox(
            width: 390,
            height: 64,
            child: Stack(children: <Widget>[
              Positioned(
                  left: 32,
                  child: Container(
                      width: 324,
                      height: 64,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        color: Colors.white,
                      )
                  )
              ),
              const Positioned(
                  left: 32,
                  width: 162,
                  height: 64,
                  top: 17,
                  child: Text(
                    "Public",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Poppins',
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                        height: 1
                    ),
                  )
              ),
              const Positioned(
                  left: 194,
                  width: 162,
                  height: 64,
                  top: 17,
                  child: Text(
                    "Private",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Poppins',
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                        height: 1
                    ),
                  )
              ),
              Positioned(
                left: 32,
                width: 324,
                height: 64,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: const MySwitch()
                ),
              ),
            ])
        ),
        SizedBox(
          width: 390,
          height: 64,
          child: Stack(children: <Widget>[
              Positioned(
                  left: 32,
                  child: Container(
                    width: 324,
                    height: 64,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        color: Colors.white
                    ),
                  )
              ),
              Positioned(
                  left: 258,
                  child: ElevatedButton(
                    onPressed: () { Get.to(const CategoryPage()); },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan,
                        fixedSize: const Size(100, 64),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        )),
                    child: const Text(
                      'Pick',
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                  )
              ),
              const Positioned(
                  left: 64,
                  top: 16,
                  child: Text(
                    'Category',
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  )
              ),
            ])
        ),
        const MySlider(),
        ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                fixedSize: const Size(280, 120),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                )),
            child: const Text(
              'Play!',
              style:  TextStyle(fontSize: 30, color: Colors.white),
            )
        ),
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
                  leftIcon: 'assets/images/profile.png',
                  rightIcon: 'assets/images/settings.png'),
            ),
            body: form(),
          )),
    );
  }

}

class MySwitch extends StatefulWidget {
  const MySwitch({super.key});

  @override
  State<MySwitch> createState() => _MySwitchState();
}

class _MySwitchState extends State<MySwitch> {
  bool selected = false;
  String name = 'Private';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 195,
      height: 64,
      child: Stack(
        children: <Widget>[
          AnimatedPositioned(
            width: 162,
            height: 64,
            left: selected ? 0 : 162,
            duration: const Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selected = !selected;
                  if(selected) {
                    name = 'Public';
                  } else {
                    name = "Private";
                  }
                });
              },
              child: Container(
                color: Colors.cyan,
                child: Center(
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 30,
                          fontWeight: FontWeight.normal,
                          height: 1
                      )
                    )
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MySlider extends StatefulWidget {
  const MySlider({super.key});

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  double _currentSliderValue = 1;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
        data: const SliderThemeData(
          trackHeight: 32,
          activeTrackColor: Colors.cyan,
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0)
        ),
        child: Slider(
          value: _currentSliderValue,
          max: 10,
          divisions: 10,
          label: _currentSliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
            });
          },
        )
    );
  }

}
