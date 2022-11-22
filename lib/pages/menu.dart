import 'package:flutter/material.dart';
import 'package:quizly_app/pages/category_page.dart';
import 'package:quizly_app/widgets/header.dart';
import 'package:get/get.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  Widget answerButton(String text) {
    return ElevatedButton(
      onPressed: () {
        if (text == 'Play!') Get.to(const CategoryPage());
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.cyan,
          fixedSize: const Size(280, 120),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          )),
      child: Text(
        text,
        style: const TextStyle(fontSize: 30, color: Colors.white),
      ),
    );
  }

  Widget bodyOfQuestion(String nickname) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
            width: 390,
            height: 219,
            child: Stack(children: <Widget>[
              Positioned(
                  left: 32,
                  child: Container(
                      width: 324,
                      height: 219,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35),
                        ),
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ))),
              Positioned(
                left: 32,
                width: 324,
                height: 219,
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Welcome!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 36,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                        Text(
                          nickname,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.cyan,
                              fontFamily: 'Poppins',
                              fontSize: 40,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                        const Text(
                          'What would you like',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 36,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                        const Text(
                          'to do today?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 36,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                      ]),
                ),
              )
            ])),
        answerButton('Play!'),
        answerButton('Create a quiz!')
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
        body: bodyOfQuestion('IronMan73'),
      )),
    );
  }
}
