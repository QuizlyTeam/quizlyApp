import 'package:flutter/material.dart';
import 'package:quizly_app/widgets/header.dart';

// ignore: must_be_immutable
class UserAccount extends StatelessWidget {
  UserAccount({Key? key, required this.values, this.x = 1, this.y = 1})
      : super(key: key) {
    if (values["lose"] != 0 || values['win'] != 0) {
      _progress = values["win"] / (values["win"] + values["lose"]);
    } else {
      _progress = 0.5;
    }

    avatarPicture = NetworkImage(values["picture"]);
    avatar = CircleAvatar(
        minRadius: 110 * y,
        backgroundColor: Colors.white,
        backgroundImage: avatarPicture);
  }

  late final Map values;

  final Color? _backgroundColor = Colors.grey[300];
  final Color _appColor = Colors.cyan;
  late double x;
  late double y;

  late double _progress;
  late NetworkImage avatarPicture;

  late final TextStyle nick = TextStyle(
      fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25 * y);

  late final TextStyle regular = TextStyle(
      fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25 * y);

  late final TextStyle title = TextStyle(
      fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25 * y);

  late Text ratio = Text('Ratio: ', style: title);
  late Text ratioStat =
      Text('${values["win"]}:${values["lose"]}', style: regular);
  late Text favQuiz = Text('Favourite quiz: ', style: title);
  late Text favQuizStat = Text(values["favourite_category"], style: regular);
  late Text mostPoints = Text('Most points: ', style: title);
  late Text mostPointsStat = Text('${values["max_points"]}', style: regular);

  late ClipRRect nickname = ClipRRect(
    borderRadius: BorderRadius.circular(30.0),
    child: Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(
        maxWidth: 300 * x,
        maxHeight: 45 * y,
      ),
      color: Colors.white,
      child: Text(values["nickname"], style: nick),
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
