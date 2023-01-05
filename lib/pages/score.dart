import 'package:flutter/material.dart';
import 'package:quizly_app/widgets/header.dart';

class Score extends StatelessWidget {
  final Map score;
  final String player;
  const Score({super.key, required this.score, required this.player});

  List<Widget> generateTable(double y){
    List<Widget> ans = [];

    score.forEach((key, value) {
      Text record = Text(
        '$key : $value',
        style: TextStyle(
          fontWeight: key == player ? FontWeight.bold : FontWeight.normal,
          fontSize: 46 * y
        ),
      );
      ans.add(record);
    });

    return ans;
  }

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
              child: Column(
                children: generateTable(y),
              ),
            ),
          )
      ),
    );
  }
}
