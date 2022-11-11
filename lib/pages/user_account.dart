import 'package:flutter/material.dart';

class UserAccount extends StatelessWidget {
  UserAccount({Key? key}) : super(key: key);

  late int _wins = 3;
  late int _loses = 1;
  late String _category = 'Dogs';
  late int _friends = 31;
  late int _mostPoints = 1043;
  late String _name = 'IronMan73';

  late final TextStyle nick = const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 25
  );

  late ClipRRect nickname = ClipRRect(
    borderRadius: BorderRadius.circular(30.0),
    child: Container(
      alignment: Alignment.center,
      constraints: const BoxConstraints(
        maxWidth: 300,
        maxHeight: 45,
      ),
      color: Colors.white,
      child: Text('ClipRRect', style: nick),
    ),
  );

  late Row appBody = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      nickname
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example title')
      ),
      // body is the majority of the screen.
      body: appBody,
     backgroundColor: Colors.grey[300],
    );
  }
}
