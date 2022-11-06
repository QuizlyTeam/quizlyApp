import 'package:flutter/material.dart';
import '';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        child: const Align(
          alignment: Alignment.topRight,
          child: Center(
            child: Image(
                image: AssetImage('assets/images/quizly.png')
            ),
          ),
        ),
      ),
    );
  }
}
