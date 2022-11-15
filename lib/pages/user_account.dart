import 'package:flutter/material.dart';
import 'package:quizly_app/widgets/header.dart';

// ignore: must_be_immutable
class UserAccount extends StatelessWidget {
  UserAccount(
      {Key? key,
      int w = 3,
      int l = 1,
      String cat = 'Dogs',
      points = 1043,
      name = 'Guest314159',
      url = 'https://img.redro.pl/obrazy/czarny-pies-700-138366861.jpg'})
      : super(key: key) {
    _wins = w;
    _loses = l;
    _category = cat;
    _mostPoints = points;
    _name = name;
    pictureUrl = url;
    if (w != 0 || l != 0) {
      _progress = w / (w + l);
    } else {
      _progress = 0.5;
    }

    if (url == '') {
      defaultPicture = Image.asset(
        'assets/images/profile.png',
        width: 150,
        height: 150,
      );
      avatar = CircleAvatar(
          minRadius: 125,
          backgroundColor: Colors.white,
          backgroundImage: defaultPicture.image);
    } else {
      avatarPicture = NetworkImage(pictureUrl);
      avatar = CircleAvatar(
          minRadius: 125,
          backgroundColor: Colors.white,
          backgroundImage: avatarPicture);
    }
  }

  final Color? _backgroundColor = Colors.grey[300];
  final Color _appColor = Colors.cyan;

  late int _wins;
  late int _loses;
  late double _progress;
  late String _category;
  late int _mostPoints;
  late String _name;
  late String pictureUrl;
  late NetworkImage avatarPicture;
  late Image defaultPicture;

  late final TextStyle nick = const TextStyle(
      fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25);

  late final TextStyle regular = const TextStyle(
      fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25);

  late final TextStyle title = const TextStyle(
      fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25);

  late Text ratio = Text('Ratio: ', style: title);
  late Text ratioStat = Text('$_wins:$_loses', style: regular);
  late Text favQuiz = Text('Favourite quiz: ', style: title);
  late Text favQuizStat = Text(_category, style: regular);
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

  late CircleAvatar avatar;

  late LinearProgressIndicator winsToLoses = LinearProgressIndicator(
    backgroundColor: Colors.red,
    color: Colors.green,
    value: _progress,
    minHeight: 15,
  );

  late Row winsRatio = Row(
    children: [
      const Text(
        'W',
        style: TextStyle(
            color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      Expanded(child: winsToLoses),
      const Text(
        'L',
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
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
      titleField(favQuiz),
      valueField(favQuizStat),
      titleField(mostPoints),
      valueField(mostPointsStat),
    ],
  );

  late ClipRRect roundedTable =
      ClipRRect(borderRadius: BorderRadius.circular(30.0), child: table);

  late SizedBox someSpace = const SizedBox(width: 300, height: 20);

  late Column appBody = Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      someSpace,
      nickname,
      someSpace,
      avatar,
      someSpace,
      ratioWrapper,
      someSpace,
      roundedTable
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
