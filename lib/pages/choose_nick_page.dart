import 'package:flutter/material.dart';
import 'package:quizly_app/auth/auth.dart';
import 'package:get/get.dart';
import 'package:quizly_app/pages/menu.dart';

class NicknamePage extends StatefulWidget {
  const NicknamePage({Key? key}) : super(key: key);

  @override
  State<NicknamePage> createState() => _NicknamePageState();
}

class _NicknamePageState extends State<NicknamePage> {
  String nickname = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width / 411.42857142857144;
    double y = MediaQuery.of(context).size.height / 866.2857142857143;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20 * x, horizontal: 50 * y),
          child: Form(
            key: _formKey,
            child: Column(children: [
              SizedBox(
                height: 20 * y,
              ),
              TextFormField(
                validator: (value) =>
                    RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value!)
                        ? null
                        : "Enter a valid nickname",
                decoration: InputDecoration(
                    hintText: "Nickname",
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 3, color: Colors.grey.shade500))),
                onChanged: (val) {
                  setState(() {
                    nickname = val;
                  });
                },
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var a = createUser(nickname);
                      if (a != null) {
                        var data = await getUser();
                        Get.to(() => MenuPage(nick: data["nickname"]));
                      }
                    }
                  },
                  child: const Text(
                    "Confirm nickname",
                    style: TextStyle(color: Colors.white),
                  ))
            ]),
          )),
    );
  }
}
