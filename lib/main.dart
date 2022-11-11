import 'package:flutter/material.dart';
import 'pages/question.dart';

void main() => runApp(MaterialApp(initialRoute: '/questionPage', routes: {
'/questionPage': (context) => const Questionpage()
  }));

