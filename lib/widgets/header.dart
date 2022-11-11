import 'package:flutter/material.dart';

//leftIcon - path ( String ) do lewej ikonki, pamietac zeby byla
//tez zadeklarowana w pubspec.yaml
//rightIcon to samo tylko po prawej
class Header extends StatelessWidget {
  final String leftIcon;
  final String rightIcon;
  const Header({
    super.key,
    required this.leftIcon,
    required this.rightIcon,
  });

  Widget header() {
    return Material(
      color: Colors.cyan,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Image(
              image: AssetImage(leftIcon),
              height: 90,
            ),
            onPressed: () {}, // null disables the button
            iconSize: 58,
          ),
          const Expanded(
            child: Image(
              image: AssetImage('assets/images/logo.png'),
              height: 60,
            ),
          ),
          IconButton(
            icon: Image(
              image: AssetImage(rightIcon),
            ),
            iconSize: 58,
            onPressed: () {},
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
