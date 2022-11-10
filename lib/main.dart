import 'package:flutter/material.dart';
import 'pages/question.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'My app', // used by the OS task switcher
      home: SafeArea(
        child: Questionpage()
      ),
    ),
  );
}

