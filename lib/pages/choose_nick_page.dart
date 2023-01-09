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

    onChanged: (val) {
    setState(() {
      nickname = val;
    });
    },
      ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan),
            onPressed: ()  {
               var a = createUser(nickname);
               if(a != null)Get.to(()=> MenuPage(nick: nickname,));
                },
            child: const Text(
              "Confirm nickname",
              style: TextStyle(color: Colors.white),
            ))
        ]
      ),
    );
  }
}
