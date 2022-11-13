import 'package:flutter/material.dart';
import 'package:quizly_app/pages/login_page.dart';
import 'pages/question.dart';
import 'pages/category_page.dart';

void main() => runApp(MaterialApp(initialRoute: '/loginPage', routes: {
      '/questionPage': (context) => const Questionpage(),
      '/categoryPage': (context) => CategoryPage(),
      '/loginPage': (context) => const LoginPage(),
    }));
