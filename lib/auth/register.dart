import 'package:flutter/material.dart';
import 'package:quizly_app/auth/auth.dart';
import 'package:get/get.dart';
import 'package:quizly_app/pages/choose_nick_page.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width / 411.42857142857144;
    double y = MediaQuery.of(context).size.height / 866.2857142857143;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Register"),
        backgroundColor: Colors.cyan,
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20 * x, horizontal: 50 * y),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 20 * y,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 3, color: Colors.grey.shade500))),
                    validator: (value) =>
                        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value!)
                            ? null
                            : 'Enter a valid email',
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20 * y,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 3, color: Colors.grey.shade500))),
                    validator: (value) => RegExp(
                                r'^(?=.*[A-Z])(?=.*[a-z])(?=.*?[0-9]).{6,}$')
                            .hasMatch(value!)
                        ? null
                        : 'Enter a  strong password (1+ upper, 1+ lower, 1+ digit)',
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20 * y,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          var result =
                              await _auth.registerUser(email, password);
                          if (result != null) {
                            Get.to(() => const NicknamePage());
                          }
                        }
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ))),
    );
  }
}
