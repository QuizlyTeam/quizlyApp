import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizly_app/auth/register.dart';
import 'package:quizly_app/pages/choose_nick_page.dart';
import 'package:quizly_app/pages/menu.dart';
import 'package:quizly_app/auth/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService auth_ = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  Widget socialLogo(String asset, double x, double y) {
    var auth_ = AuthService();
    // ignore: prefer_typing_uninitialized_variables
    var result;
    return SizedBox(
        width: 120 * x,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.cyan,
          ),
          onPressed: () async {

            if (asset == 'assets/images/Facebook (icon — Colour).png') {
              result = await auth_.signInWithFacebook();
              if (result != null){
                if(await getUser() == null){Get.to(() => const NicknamePage());}
                else{
                  var data = await getUser();
                  Get.to(()=>MenuPage(nick: data['nickname'],));
                }
              }
            } else if (asset == 'assets/images/Google (icon — Colour).png') {
              result = await auth_.signInWithGoogle();
              if (result != null) {
                if(await getUser() == null){Get.to(() => const NicknamePage());}
                else {
                  var data = await getUser();
                  Get.to(()=>MenuPage(nick: data['nickname'],));
                }
              }
            } else if (asset == 'assets/images/Mask group.png') {
              result = await auth_.signInWithApple();
              if (result != null){
                if(await getUser() == null){Get.to(() => const NicknamePage());}
                else{
                  var data = await getUser();
                  Get.to(()=>MenuPage(nick: data['nickname'],));
                }
              }
            }
          },
          child: Padding(
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
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 20 * y,
                  ),
                  Center(
                    child: Image(
                      image: const AssetImage('assets/images/Group 5.png'),
                      height: 160 * y,
                    ),
                  ),
                  SizedBox(
                    height: 20 * y,
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
                      child: TextFormField(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30 * y),
                              borderSide: BorderSide.none),
                          hintText: "Email",
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15) * y,
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(36.84 * y),
                            borderSide: BorderSide.none),
                        hintText: "Password",
                        suffixIcon: IconButton(
                          icon: Image.asset('assets/images/Arrow 1.png',
                              color: Colors.grey.shade500),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              var result =
                                  await auth_.loginUser(email, password);
                              if (result != null) {
                                var data = await getUser();
                                Get.to(() => MenuPage(nick: data['nickname'],));
                              }
                            }
                          },
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
                      Get.to(const Register());
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25 * y),
                        ),
                        maximumSize: Size(320 * x, 70 * y),
                        backgroundColor: Colors.white),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius:
                              BorderRadius.all(Radius.circular(25 * y))),
                      child: Center(
                        child: Text(
                          'Register',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 38 * y,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20 * y,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      var result = auth_.signInAnon();
                      if(result != null) {
                        var data = await getUser();
                        Get.to(MenuPage(nick: data['nickname'],));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25 * y),
                        ),
                        maximumSize: Size(320 * x, 70 * y),
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
      ),
    );
  }
}
