import 'package:flutter/material.dart';
import 'package:quizly_app/widgets/header.dart';

/// Show account stats.
///
/// This option is only available for logged users. It shows ration between
/// wins and failures in multiplayer games, favourite category of user and
/// his highest score.
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

  /// Contains information about wined and lost games.
  late final Map values;

  /// Application background color.
  final Color? _backgroundColor = Colors.grey[300];
  /// Application color of buttons.
  final Color _appColor = Colors.cyan;
  /// Scaling factor of horizontal axis of app.
  late double x;
  /// Scaling factor of vertical axis of app.
  late double y;

  /// Ratio wins:loses.
  late double _progress;
  ///Users avatar picture.
  late NetworkImage avatarPicture;

  /// Style of text which shows user's nick.
  late final TextStyle nick = TextStyle(
      fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25 * y);

  /// Style of text which shows stat value.
  late final TextStyle regular = TextStyle(
      fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25 * y);

  /// Style of text which shows stat's name.
  late final TextStyle title = TextStyle(
      fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25 * y);

  /// Title of stat 'ratio'.
  late Text ratio = Text('Ratio: ', style: title);
  /// Value of stat 'ratio'.
  late Text ratioStat =
      Text('${values["win"]}:${values["lose"]}', style: regular);
  /// Title of stat 'Favourite quiz'.
  late Text favQuiz = Text('Favourite quiz: ', style: title);
  /// Value of stat 'Favourite quiz'.
  late Text favQuizStat = Text(values["favourite_category"], style: regular);
  /// Title of stat 'Most points'.
  late Text mostPoints = Text('Most points: ', style: title);
  /// Value of stat 'Most points'.
  late Text mostPointsStat = Text('${values["max_points"]}', style: regular);

  /// Shows user's nickname.
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

  /// Show's user profile picture.
  late CircleAvatar avatar;

  /// Show's ration win/lose as progress bar.
  late LinearProgressIndicator winsToLoses = LinearProgressIndicator(
    backgroundColor: Colors.red,
    color: Colors.green,
    value: _progress,
    minHeight: 25 * y,
  );

  /// Nice wraps ratio win/lose with information what is at left and right.
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

  /// Wraps wins ratio into fixed size container.
  late Container ratioWrapper = Container(
    alignment: Alignment.center,
    constraints: BoxConstraints(
      maxWidth: 300 * x,
      maxHeight: 45 * y,
    ),
    child: winsRatio,
  );

  /// Title row of stats' table.
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

  /// Value row of stats' table.
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

  /// Stats' table.
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

  /// Fancy look of stats' table.
  late ClipRRect roundedTable =
      ClipRRect(borderRadius: BorderRadius.circular(30.0), child: table);

  /// Widgets separator.
  late SizedBox someSpace = SizedBox(width: 300 * x, height: 20 * y);

  /// Body of page.
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
