import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserAccount extends StatelessWidget {
  UserAccount({Key? key}) : super(key: key);

  final Color? _backgroundColor = Colors.grey[300];
  final Color _appColor = Colors.cyan;

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

  late final TextStyle regular = const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 20
  );

  late final TextStyle title = const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 20
  );

  late Text ratio = Text('Ratio: ', style: title);
  late Text ratioStat = Text('$_wins:$_loses', style: regular);
  late Text favQuiz = Text('Favourite quiz: ', style: title);
  late Text favQuizStat = Text(_category, style: regular);
  late Text friends = Text('Friends: ', style: title);
  late Text friendsStat = Text('$_friends', style: regular);
  late Text mostPoints = Text('Most points: ', style: title);
  late Text mostPointsStat = Text('$_mostPoints', style: regular);

  late ClipRRect nickname = ClipRRect(
    borderRadius: BorderRadius.circular(30.0),
    child: Container(
      alignment: Alignment.center,
      constraints: const BoxConstraints(
        maxWidth: 300,
        maxHeight: 45,
      ),
      color: Colors.white,
      child: Text(_name, style: nick),
    ),
  );

  late CircleAvatar avatar = const CircleAvatar(
    minRadius: 125,
    backgroundImage: AssetImage('assets/images/profile_picture.jpg')
  );

  late LinearProgressIndicator winsToLoses = LinearProgressIndicator(
    backgroundColor: Colors.red,
    color: Colors.green,
    value: _wins/(_wins+_loses),
    minHeight: 15,
  );

  late Row winsRatio = Row(
    children: [
      const Text(
        'W',
        style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
          fontSize: 20
        ),
      ),
      Expanded(child: winsToLoses),
      const Text(
        'L',
        style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 20
        ),
      ),
    ],
  );

  late Container ratioWrapper = Container(
    alignment: Alignment.center,
    constraints: const BoxConstraints(
      maxWidth: 300,
      maxHeight: 45,
    ),
    child: winsRatio,
  );

  Container titleField(Text t) {
    return Container(
      alignment: Alignment.center,
      constraints: const BoxConstraints(
        maxWidth: 300,
        maxHeight: 30,
      ),
      color: _appColor,
      child: t,
    );
  }

  Container valueField(Text t) {
    return Container(
      alignment: Alignment.center,
      constraints: const BoxConstraints(
        maxWidth: 300,
        maxHeight: 30,
      ),
      color: Colors.white,
      child: t,
    );
  }

  late Column table = Column(
    children: [
      titleField(ratio),
      valueField(ratioStat),
      titleField(favQuiz),
      valueField(favQuizStat),
      titleField(friends),
      valueField(friendsStat),
      titleField(mostPoints),
      valueField(mostPointsStat),
    ],
  );

  late ClipRRect roundedTable = ClipRRect(
    borderRadius: BorderRadius.circular(30.0),
    child: table
  );

  late Column appBody = Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      nickname,
      avatar,
      ratioWrapper,
      roundedTable
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
     backgroundColor: _backgroundColor,
    );
  }
}
