import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  Widget header() {
    return AppBar(
      backgroundColor: Colors.cyan,
      toolbarHeight: 75,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
      ),
      title: Row(
        children: [
          IconButton(
            icon: const Image(image: AssetImage('assets/images/back.png'),height: 90,),
            onPressed: (){}, // null disables the button
            iconSize: 58  ,
          ),
          const Expanded(
            child: Image(
              image: AssetImage('assets/images/logo.png'),
              height: 60,
            ),
          ),
          IconButton(
            icon: const Image(
              image: AssetImage('assets/images/settings.png'),

            ),
            iconSize: 58,
            onPressed: (){},
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return header();
  }
}