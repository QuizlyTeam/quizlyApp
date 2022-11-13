import 'package:flutter/material.dart';
import 'package:quizly_app/pages/loginPage.dart';
import 'pages/question.dart';
import 'pages/categoryPage.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/loginPage', routes: {
    '/questionPage': (context) => const Questionpage(),
    '/categoryPage': (context) => CategoryPage(),
    '/loginPage' : (context) => const LoginPage(),
  }));
