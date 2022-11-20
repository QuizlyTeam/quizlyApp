

import 'package:flutter/material.dart';
import 'package:quizly_app/pages/login_page.dart';
import 'package:quizly_app/pages/user_account.dart';
import 'pages/question.dart';
import 'pages/category_page.dart';
import 'pages/after_logging.dart';

void main() => runApp(MaterialApp(initialRoute: '/after_logging', routes: {
      '/questionPage': (context) => const Questionpage(),
      '/categoryPage': (context) => CategoryPage(),
      '/loginPage': (context) => const LoginPage(),
      '/user_account': (context) => UserAccount(
            w: 3,
            l: 2,
            url: '',
          ),
    '/after_logging': (context) => AfterLogging()
    }));
