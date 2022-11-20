import 'package:flutter/material.dart';
import 'package:quizly_app/widgets/header.dart';

class AfterLogging extends StatefulWidget {
  const AfterLogging({super.key});

  @override
  State<AfterLogging> createState() => _AfterLoggingState();
}

class _AfterLoggingState extends State<AfterLogging> {

  final Color? _backgroundColor = Colors.grey[300];
  final ButtonStyle style =
  ElevatedButton.styleFrom(
    backgroundColor: Colors.cyan,
    textStyle: const TextStyle(fontSize: 50, ),
  );

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
        child: const Text('My quizzes'),
      ),
    ),
  );

  late SizedBox someSpace = const SizedBox(width: 300, height: 75);
  late SizedBox moreSpace = const SizedBox(width: 300, height: 200);

  late Column appBody = Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      moreSpace,
      playButton,
      someSpace,
      quizButton,
      moreSpace
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
        child: Center(child: appBody),
      ),
      backgroundColor: _backgroundColor,
    );
  }
}