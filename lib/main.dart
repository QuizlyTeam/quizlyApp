import 'package:flutter/material.dart';
import 'package:quizly_app/pages/user_account.dart';
import 'package:quizly_app/pages/question.dart';

void main() => runApp(MaterialApp(initialRoute: '/user_account', routes: {
  '/questionPage': (context) => const Questionpage(),
  '/user_account': (context) => UserAccount(w: 0, l:0, url: '',)
}));
