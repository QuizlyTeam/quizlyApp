// ignore: library_prefixes
import 'package:quizly_app/pages/question.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:quizly_app/widgets/header.dart';
import 'package:get/get.dart';

class BetweenPage extends StatefulWidget {
  final IO.Socket socket = IO.io('http://10.0.2.2:8000/',
      IO.OptionBuilder().setTransports(['websocket']).build());
  final String category;
  final List<String> tags;
  final int maxPlayers;
  final int numOfQuestions;
  final String difficulty;

  BetweenPage({
        super.key,
        required this.category,
        required this.tags,
        required this.maxPlayers,
        required this.numOfQuestions,
        required this.difficulty
      });

  @override
  State<BetweenPage> createState() => _BetweenPageState();
}

class _BetweenPageState extends State<BetweenPage>{
  @override
  void initState() {
    super.initState();

    String cat = widget.category.replaceFirst(r' & ', '_and_').toLowerCase();

    var quizOptions = {};

    quizOptions["nickname"] = "guest";
    cat.isEmpty ? 1+1:quizOptions["categories"] = cat;
    quizOptions["difficulty"] = widget.difficulty;
    quizOptions["limit"] = widget.numOfQuestions;
    widget.tags.isNotEmpty ? quizOptions["tags"]:1+1;
    quizOptions["max_players"] = widget.maxPlayers;


    widget.socket.emit("join", quizOptions);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => Get.to(Question(
      socket: widget.socket,
      numOfQuestions: widget.numOfQuestions,
    )));
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
            body: SingleChildScrollView(
              child: ElevatedButton(
                  onPressed: () {
                    Get.to(Question(
                      socket: widget.socket,
                      numOfQuestions: widget.numOfQuestions,
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      fixedSize: Size(280 * x, 96 * y),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      )),
                  child: Text(
                    'Play!',
                    style: TextStyle(fontSize: 30 * y, color: Colors.white),
                  )
              ),
            ),
          ),
        ));
  }

}

