import 'package:flutter/material.dart';
import 'package:quizly_app/widgets/header.dart';

class Score extends StatelessWidget {
  final int score;
  const Score({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    double y = MediaQuery.of(context).size.height / 866.2857142857143;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Header(
            leftIcon: 'assets/images/profile.png',
            rightIcon: 'assets/images/settings.png',
            y: y,
          ),
        ),
        body: Center(
          child: Text(
            'Your score: \n$score',
            style: const TextStyle(fontSize: 48),
          ),
        ),
      )),
    );
  }
}
