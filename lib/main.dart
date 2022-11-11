import 'package:flutter/material.dart';
import 'pages/question.dart';
import 'pages/mainPage.dart';

void main() => runApp(MaterialApp(initialRoute: '/questionPage', routes: {
'/questionPage': (context) => const Questionpage()
  }));

