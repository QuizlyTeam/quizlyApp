import 'package:flutter/material.dart';
import 'package:quizly_app/pages/login_page.dart';
import 'package:quizly_app/pages/user_account.dart';
import 'pages/question.dart';
import 'pages/category_page.dart';

void main() => runApp(MaterialApp(initialRoute: '/user_account', routes: {
      '/questionPage': (context) => const Questionpage(),
      '/categoryPage': (context) => CategoryPage(),
      '/loginPage': (context) => const LoginPage(),
      '/user_account': (context) => UserAccount(
            w: 0,
            l: 0,
            url: '',
          )
    }));
