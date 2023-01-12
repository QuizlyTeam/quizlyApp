import 'package:flutter/material.dart';
import 'package:quizly_app/auth/auth.dart';
import 'package:quizly_app/pages/create_quiz_page.dart';
import 'package:quizly_app/pages/game_form.dart';
import 'package:quizly_app/widgets/header.dart';
import 'package:get/get.dart';

class MenuPage extends StatelessWidget {
  final String nick;

  const MenuPage({super.key, required this.nick});

  Widget answerButton(String text, double x, double y) {
    return ElevatedButton(
      onPressed: () async {
        var data = await getUser();
        if (data != null) {
          if (text == 'Play!') {
            Get.to(GameForm(nick: nick, uID: data['uid'],));
          } else {
            Get.to(const CreateQuizForm());
          }
        } else {
          if (text == 'Play!') {
            Get.to(GameForm(nick: nick,));
          }
        }
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.cyan,
          fixedSize: Size(280 * x, 120 * y),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          )),
      child: Text(
        text,
        style: TextStyle(fontSize: 30 * y, color: Colors.white),
      ),
    );
  }

  Widget bodyOfQuestion(String nickname, double x, double y) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
            width: 390 * x,
            height: 219 * y,
            child: Stack(children: <Widget>[
              Positioned(
                  left: 32 * x,
                  child: Container(
                      width: 324 * x,
                      height: 219 * y,
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
                left: x * 32,
                width: x * 324,
                height: y * 219,
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height: 20 * y),
                        Text(
                          'Welcome!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 36 * y,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                        Text(
                          nickname,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.cyan,
                              fontFamily: 'Poppins',
                              fontSize: 40 * y,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                        Text(
                          'What would you like',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 36 * y,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                        Text(
                          'to do today?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 36 * y,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                      ]),
                ),
              )
            ])),
        answerButton('Play!', x, y),
        answerButton('Create a quiz!', x, y)
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
            body: bodyOfQuestion(nick, x, y),
        )
      ),
    );
  }
}
