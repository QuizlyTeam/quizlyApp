import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizly_app/pages/settings.dart';
import 'package:quizly_app/pages/user_account.dart';

//leftIcon - path ( String ) do lewej ikonki, pamietac zeby byla
//tez zadeklarowana w pubspec.yaml
//rightIcon to samo tylko po prawej
class Header extends StatelessWidget {
  final String leftIcon;
  final String rightIcon;
  final double y;
  const Header({
    super.key,
    required this.leftIcon,
    required this.rightIcon,
    required this.y,
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
              height: 90 * y,
            ),
            onPressed: () {
              if (leftIcon == 'assets/images/profile.png') {
                Get.to(UserAccount());
              } else if (leftIcon == 'assets/images/back.png') {
                Get.back();
              }
            }, // null disables the button
            iconSize: 58 * y,
          ),
          Expanded(
            child: Image(
              image: const AssetImage('assets/images/logo.png'),
              height: 60 * y,
            ),
          ),
          IconButton(
            icon: Image(
              image: AssetImage(rightIcon),
            ),
            iconSize: 58 * y,
            onPressed: () {
              if (rightIcon == 'assets/images/settings.png') {
                Get.to(const SettingsPage());
              }
            },
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
