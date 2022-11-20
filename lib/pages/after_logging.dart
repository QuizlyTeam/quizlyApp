import 'package:flutter/material.dart';
import 'package:quizly_app/widgets/header.dart';

class AfterLogging extends StatelessWidget {
  AfterLogging({super.key});

  final Color _backgroundColor = const Color(0xFF90A4AE);
  final ButtonStyle style =
  ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  late ClipRRect playButton = ClipRRect(
    borderRadius: BorderRadius.circular(30.0),
    child: SizedBox(
      width: 300,
      height: 100,
      child: ElevatedButton(
        style: style,
        onPressed: () {},
        child: const Text('Play'),
      ),
    ),
  );

  late ClipRRect quizButton = ClipRRect(
    borderRadius: BorderRadius.circular(30.0),
    child: SizedBox(
      width: 300,
      height: 100,
      child: ElevatedButton(
        style: style,
        onPressed: () {},
        child: const Text(''),
      ),
    ),
  );

  late Column appBody = Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      playButton,
      quizButton
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Header(
            leftIcon: 'assets/images/back.png',
            rightIcon: 'assets/images/settings.png'),
      ),
      // body is the majority of the screen.
      body: SingleChildScrollView(
        child: appBody,
      ),
      backgroundColor: _backgroundColor,
    );
  }
}