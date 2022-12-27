import 'package:flutter/material.dart';
import 'package:quizly_app/widgets/header.dart';

class Score extends StatelessWidget {
  final int score;
  const Score({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: Header(
                  leftIcon: 'assets/images/profile.png',
                  rightIcon: 'assets/images/settings.png'),
            ),
            body: Center(
              child: Text(
                'Your score: ${score*587}',
                style: const TextStyle(fontSize: 48),
              ),
            ),
          )),
    );
  }
}