import 'package:flutter/material.dart';
import 'package:quizly_app/pages/user_account.dart';

void main() => runApp(MaterialApp(initialRoute: '/user_account', routes: {
  '/user_account': (context) => UserAccount(w: 0, l:0, url: '',)
}));