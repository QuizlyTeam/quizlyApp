import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizly_app/pages/menu.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  Widget socialLogo(String asset, double x, double y) {
    return Padding(
        padding: EdgeInsets.all(5 * y),
        child: SizedBox(
          height: 50 * y,
          width: 100 * x,
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Center(
              child: Image(
                image: AssetImage(asset),
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width / 411.42857142857144;
    double y = MediaQuery.of(context).size.height / 866.2857142857143;
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.cyan,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30 * y,
                ),
                Center(
                  child: Image(
                    image: const AssetImage('assets/images/Group 5.png'),
                    height: 220 * y,
                  ),
                ),
                SizedBox(
                  height: 30 * y,
                ),
                Center(
                  child: Text(
                    'Welcome to Quizly!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 43 * y,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10 * y,
                ),
                Center(
                  child: Text(
                    'Sign in:',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 43 * y,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15 * y),
                  child: Center(
                    child: TextField(
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30 * y),
                            borderSide: BorderSide.none),
                        hintText: "Username",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15) * y,
                  child: TextField(
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(36.84 * y),
                          borderSide: BorderSide.none),
                      hintText: "Password",
                      suffixIcon: IconButton(
                        icon: Image.asset('assets/images/Arrow 1.png'),
                        onPressed: () {},
                        iconSize: 20 * y,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    socialLogo(
                        'assets/images/Facebook (icon — Colour).png', x, y),
                    socialLogo(
                        'assets/images/Google (icon — Colour).png', x, y),
                    socialLogo('assets/images/Mask group.png', x, y),
                  ],
                ),
                SizedBox(
                  height: 5 * y,
                ),
                Text(
                  "or",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 43 * y,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5 * y,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(const MenuPage(),
                        transition: Transition.rightToLeftWithFade,
                        duration: const Duration(milliseconds: 500));
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25 * y),
                      ),
                      maximumSize: Size(320 * x, 80 * y),
                      backgroundColor: Colors.white),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius:
                            BorderRadius.all(Radius.circular(25 * y))),
                    child: Center(
                      child: Text(
                        'Play  as guest',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 38 * y,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
