import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizly_app/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quizly_app/pages/menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizly_app/api_functions/functions.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: "lib/.env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (FirebaseAuth.instance.currentUser != null) {
    var data = await getUser();
    if (data != null) {
      runApp(GetMaterialApp(
          home: MenuPage(
        nick: data['nickname'],
      )));
    } else {
      int end = (DateTime.now().millisecondsSinceEpoch / 1000).round();
      String nickname = "guest$end";
      runApp(GetMaterialApp(
          home: MenuPage(
        nick: nickname,
      )));
    }
  } else {
    runApp(const GetMaterialApp(home: LoginPage()));
  }
}
