import 'package:flutter/services.dart';
import 'package:quizly_app/pages/question.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:quizly_app/widgets/header.dart';
import 'package:get/get.dart';
import 'package:quizly_app/services/socket_config.dart';

/// A page shown between game form and actual game.
///
/// Gives information about number of players whose are in room, maximum number
/// of players that can be in the room and room ID, which allows your friends
/// join the game.
class BetweenPage extends StatefulWidget {
  /// Socket with which a player connects after choosing game options.
  final IO.Socket socket = IO.io(
      config["ip"], IO.OptionBuilder().setTransports(['websocket']).build());
  /// Quiz's category chosen by user.
  final String category;
  /// Quiz's tags chosen by user.
  final List<String> tags;
  /// Maximal number of players in the game.
  final int maxPlayers;
  /// Chosen by player length of quiz.
  final int numOfQuestions;
  ///  Questions' difficulty chosen by user.
  final String difficulty;
  /// ID of the room user wants to join.
  final String roomID;
  /// Database's user ID.
  final String quizID;
  /// Database's ID of quiz which user wants to play.
  final String uID;
  /// User's nickname.
  final String nick;

  BetweenPage({
    super.key,
    this.category = "",
    this.tags = const [],
    this.maxPlayers = 0,
    this.numOfQuestions = 0,
    this.difficulty = "",
    this.roomID = "",
    required this.nick,
    this.quizID = "",
    required this.uID,
  });

  @override
  State<BetweenPage> createState() => _BetweenPageState();
}

class _BetweenPageState extends State<BetweenPage> {
  int ready = 1; //number of ready players
  String room = ""; //room id
  int maxPlayers = 0; // maximum number of players

  @override
  void initState() {
    super.initState();

    //get maximum number of players from widget
    maxPlayers = widget.maxPlayers;

    //fix category name
    String cat = widget.category.replaceFirst(r' & ', '_and_').toLowerCase();

    var quizOptions = {};

    //assign proper parameters to quiz options
    quizOptions["nickname"] = widget.nick;
    cat.isEmpty ? 1 : quizOptions["categories"] = cat;
    widget.difficulty.isEmpty
        ? 1
        : quizOptions["difficulty"] = widget.difficulty;
    widget.numOfQuestions == 0
        ? 1
        : quizOptions["limit"] = widget.numOfQuestions;
    widget.tags.isNotEmpty ? quizOptions["tags"] : 1 + 1;
    widget.maxPlayers == 0 ? 1 : quizOptions["max_players"] = widget.maxPlayers;
    widget.roomID.isEmpty ? 1 : quizOptions["room"] = widget.roomID;
    widget.uID.isEmpty ? 1 : quizOptions["uid"] = widget.uID;
    widget.quizID.isEmpty ? 1 : quizOptions["quiz_id"] = widget.quizID;

    //connect to the game
    widget.socket.emit("join", quizOptions);

    if (widget.maxPlayers != 1) {
      widget.socket.on('join', (data) {
        setState(() {
          //getting room parameters
          room = data["room"];
          ready = data["number_of_players"];
          maxPlayers = data["max_number_of_players"];

          if (maxPlayers == ready) {
            //going to quiz page
            WidgetsBinding.instance.addPostFrameCallback((_) => Get.to(Question(
                  socket: widget.socket,
                  numOfQuestions: widget.numOfQuestions,
                  player: widget.nick,
                )));
          }
        });
      });

      //going to quiz after waiting too long
      widget.socket.on(
          'timeout',
          (_) => Get.to(Question(
                socket: widget.socket,
                numOfQuestions: widget.numOfQuestions,
                player: widget.nick,
              )));

      //give websocket signal that player is ready
      WidgetsBinding.instance
          .addPostFrameCallback((_) => widget.socket.emit("ready"));
    }

    if (widget.maxPlayers == 1) {
      //goes to quiz page
      WidgetsBinding.instance.addPostFrameCallback((_) => Get.to(Question(
            socket: widget.socket,
            numOfQuestions: widget.numOfQuestions,
            player: widget.nick,
          )));
    }
  }

  @override
  void dispose() {
    super.dispose();
    //closes socket when element destroyed
    widget.socket.close();
  }

  @override
  Widget build(BuildContext context) {
    //scaling factors
    double x = MediaQuery.of(context).size.width / 411.42857142857144;
    double y = MediaQuery.of(context).size.height / 866.2857142857143;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
              backgroundColor: Colors.grey[300],
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(70 * y),
                child: Header(
                  leftIcon: 'assets/images/back.png',
                  rightIcon: 'assets/images/settings.png',
                  y: y,
                ),
              ),
              body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      //information about room
                      child: Text(
                        "Ready players:\n"
                        "$ready/$maxPlayers\n"
                        "Room id:\n"
                        "$room",
                        style: TextStyle(
                          fontSize: 35 * x,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      //Copy button
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                            onPressed: () async {
                              await Clipboard.setData(
                                  ClipboardData(text: room));
                            },
                            icon: const Icon(Icons.content_copy_outlined)),
                        const Text("Copy to clipboard"),
                      ],
                    )
                  ])),
        ));
  }
}
