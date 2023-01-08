import 'package:flutter/services.dart';
import 'package:quizly_app/pages/question.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:quizly_app/widgets/header.dart';
import 'package:get/get.dart';
import 'package:quizly_app/services/socket_config.dart';

class BetweenPage extends StatefulWidget {
  final IO.Socket socket = IO.io(config["ip"],
      IO.OptionBuilder().setTransports(['websocket']).build());
  final String category;
  final List<String> tags;
  final int maxPlayers;
  final int numOfQuestions;
  final String difficulty;
  final String roomID;
  final String quizID;
  final String uID;
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
        this.uID = "",
      });

  @override
  State<BetweenPage> createState() => _BetweenPageState();
}

class _BetweenPageState extends State<BetweenPage>{
  int ready = 1;
  String room = "";
  int maxPlayers = 0;

  @override
  void initState() {
    super.initState();

    String cat = widget.category.replaceFirst(r' & ', '_and_').toLowerCase();

    var quizOptions = {};

    quizOptions["nickname"] = widget.nick;
    cat.isEmpty ? 1:quizOptions["categories"] = cat;
    widget.difficulty.isEmpty ? 1:quizOptions["difficulty"] = widget.difficulty;
    widget.numOfQuestions == 0 ? 1:quizOptions["limit"] = widget.numOfQuestions;
    widget.tags.isNotEmpty ? quizOptions["tags"]:1+1;
    widget.maxPlayers == 0 ? 1:quizOptions["max_players"] = widget.maxPlayers;
    widget.roomID.isEmpty ? 1:quizOptions["room"] = widget.roomID;
    widget.uID.isEmpty ? 1:quizOptions["uid"] = widget.uID;
    widget.quizID.isEmpty ? 1:quizOptions["quiz_id"] = widget.quizID;

    widget.socket.emit("join", quizOptions);

    if (widget.maxPlayers != 1) {
      widget.socket.on('join', (data) {
        setState(() {
          room = data["room"];
          ready = data["number_of_players"];
          maxPlayers = data["max_number_of_players"];

          if (maxPlayers == ready) {
            WidgetsBinding.instance
                .addPostFrameCallback((_) =>
                Get.to(Question(
                  socket: widget.socket,
                  numOfQuestions: widget.numOfQuestions,
                  player: widget.nick,
                )));
          }
        });
      });

      widget.socket.on('timeout', (_) => print("timeout"));

      WidgetsBinding.instance
          .addPostFrameCallback((_) => widget.socket.emit("ready"));
    }

    if (widget.maxPlayers == 1) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) =>
          Get.to(Question(
            socket: widget.socket,
            numOfQuestions: widget.numOfQuestions,
            player: widget.nick,
          )));
    }

  }

  @override
  Widget build(BuildContext context) {
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
                  child: Text("Ready players:\n"
                      " $ready/$maxPlayers\n"
                      "Room id:\n"
                      "$room",
                  style: TextStyle(
                    fontSize: 35 * x,
                  ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                        onPressed: () async {
                          await Clipboard.setData(ClipboardData(text: room));
                        },
                        icon: const Icon(Icons.content_copy_outlined)
                    ),
                    const Text("Copy to clipboard"),
                  ],
                )
              ]
            )
          ),
        ));
  }

}

