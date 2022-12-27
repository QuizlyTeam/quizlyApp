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
      url = 'https://img.redro.pl/obrazy/czarny-pies-700-138366861.jpg',
      double x1 = 1,
      double y1 = 1})
      : super(key: key) {
    _wins = w;
    _loses = l;
    _category = cat;
    _mostPoints = points;
    _name = name;
    pictureUrl = url;
    x = x1;
    y = y1;
    if (w != 0 || l != 0) {
      _progress = w / (w + l);
    } else {
      _progress = 0.5;
    }

    if (url == '') {
      defaultPicture = Image.asset(
        'assets/images/profile.png',
        width: 150 * x,
        height: 150 * y,
      );
      avatar = CircleAvatar(
          minRadius: 125 * y,
          backgroundColor: Colors.white,
          backgroundImage: defaultPicture.image);
    } else {
      avatarPicture = NetworkImage(pictureUrl);
      avatar = CircleAvatar(
          minRadius: 110 * y,
          backgroundColor: Colors.white,
          backgroundImage: avatarPicture);
    }
  }

  final Color? _backgroundColor = Colors.grey[300];
  final Color _appColor = Colors.cyan;
  late double x;
  late double y;
  late int _wins;
  late int _loses;
  late double _progress;
  late String _category;
  late int _mostPoints;
  late String _name;
  late String pictureUrl;
  late NetworkImage avatarPicture;
  late Image defaultPicture;

  late final TextStyle nick = TextStyle(
      fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25 * y);

  late final TextStyle regular = TextStyle(
      fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25 * y);

  late final TextStyle title = TextStyle(
      fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25 * y);

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
      constraints: BoxConstraints(
        maxWidth: 300 * x,
        maxHeight: 45 * y,
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
    minHeight: 25 * y,
  );

  late Row winsRatio = Row(
    children: [
      Text(
        'W',
        style: TextStyle(
            color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20 * y),
      ),
      Expanded(child: winsToLoses),
      Text(
        'L',
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20 * y),
      ),
    ],
  );

  late Container ratioWrapper = Container(
    alignment: Alignment.center,
    constraints: BoxConstraints(
      maxWidth: 300 * x,
      maxHeight: 45 * y,
    ),
    child: winsRatio,
  );

  Container titleField(Text t) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(
        maxWidth: 300 * x,
        maxHeight: 40 * y,
      ),
      color: _appColor,
      child: t,
    );
  }

  Container valueField(Text t) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(
        maxWidth: 300 * x,
        maxHeight: 40 * y,
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

  late SizedBox someSpace = SizedBox(width: 300 * x, height: 20 * y);

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
    x = MediaQuery.of(context).size.width / 411.42857142857144;
    y = MediaQuery.of(context).size.height / 866.2857142857143;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70 * y),
          child: Header(
            leftIcon: 'assets/images/back.png',
            rightIcon: 'assets/images/settings.png',
            y: y,
          ),
        ),
        // body is the majority of the screen.
        body: SingleChildScrollView(
          child: appBody,
        ),
        backgroundColor: _backgroundColor,
      ),
    );
  }
}
