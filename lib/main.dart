import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizly_app/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quizly_app/pages/menu.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (FirebaseAuth.instance.currentUser != null) {
    print(FirebaseAuth.instance.currentUser?.toString());
    runApp(const GetMaterialApp(home: MenuPage()));
  } else {
    runApp(const GetMaterialApp(home: LoginPage()));
  }
}
