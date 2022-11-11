import 'package:flutter/material.dart';
import 'pages/question.dart';
import 'pages/categoryPage.dart';

void main() => runApp(MaterialApp(initialRoute: '/categoryPage', routes: {
      '/questionPage': (context) => const Questionpage(),
      '/categoryPage': (context) => const CategoryPage(),
}));
