import 'package:flutter/material.dart';
import 'package:quizly_app/pages/home.dart';

void main() => runApp(MaterialApp(initialRoute: '/home', routes: {
  '/home': (context) => const Home()
}));