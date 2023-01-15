import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizly_app/pages/settings.dart';
import 'package:quizly_app/pages/user_account.dart';
import 'package:quizly_app/api_functions/functions.dart';

/// Stateless WIdget used as Appbar
class Header extends StatelessWidget {
  /// left icon of appbar
  final String leftIcon;
  ///right icon of appbar
  final String rightIcon;
  ///variable used for changing height of Appbar on different devices
  final double y;
  const Header({
    super.key,
    required this.leftIcon,
    required this.rightIcon,
    required this.y,
  });
  //appbar widget used in many pages
  Widget header(context) {
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
            onPressed: () async {
              if (leftIcon == 'assets/images/profile.png') {
                var data = await getUser();
                if (data != null) {
                  Get.to(UserAccount(
                    values: data,
                  ));
                } else {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Guest detected'),
                      content: const Text('Log in first to see your stats!'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
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
                Get.to(const SettingsPage(), opaque: false);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return header(context);
  }
}
