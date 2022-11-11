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
  late Text ratioStat = Text('$_wins:$_loses', style: title);
  late Text favQuiz = Text('Ratio: ', style: title);
  late Text favQuizStat = Text('Ratio: ', style: title);
  late Text friends = Text('Ratio: ', style: title);
  late Text friendsStat = Text('Ratio: ', style: title);
  late Text mostPoints = Text('Ratio: ', style: title);
  late Text mostPointsStat = Text('Ratio: ', style: title);

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

  late CircleAvatar avatar = const CircleAvatar(
    minRadius: 100,
    backgroundImage: AssetImage('assets/images/profile_picture.jpg')
  );

  Container titleField(Text t) {
    return Container(
      alignment: Alignment.center,
      constraints: const BoxConstraints(
        maxWidth: 300,
        maxHeight: 40,
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
        maxHeight: 40,
      ),
      color: Colors.white,
      child: t,
    );
  }

  late Column table = Column(
    children: [
      titleField(ratio),
      valueField(ratioStat),
      titleField(ratio),
      valueField(ratioStat),
      titleField(ratio),
      valueField(ratioStat),
      titleField(ratio),
      valueField(ratioStat),
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
