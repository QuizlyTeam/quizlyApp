import 'package:flutter/material.dart';
import '../widgets/slider.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width / 411.42857142857144;
    double y = MediaQuery.of(context).size.height / 866.2857142857143;
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          color: Colors.black,
          child: Center(
              child: Container(
                  width: 317 * x,
                  height: 420 * y,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE2E2E2),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45),
                      topRight: Radius.circular(45),
                      bottomLeft: Radius.circular(45),
                      bottomRight: Radius.circular(45),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 77 * y,
                        width: 317 * x,
                        decoration: const BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(45),
                            topRight: Radius.circular(45),
                            bottomLeft: Radius.circular(45),
                            bottomRight: Radius.circular(45),
                          ),
                        ),
                        child: Center(
                            child: DefaultTextStyle(
                          style: TextStyle(
                              fontSize: 36 * y,
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                          child: const Text(
                            'Settings',
                            textDirection: TextDirection.ltr,
                          ),
                        )),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 15 * y,
                          ),
                          DefaultTextStyle(
                            style: TextStyle(
                                fontSize: 36 * y,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                            child: const Text(
                              'Music',
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                          const QuizlySlider(),
                          DefaultTextStyle(
                            style: TextStyle(
                                fontSize: 36 * y,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                            child: const Text(
                              'Sound',
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                          const QuizlySlider(),
                          SizedBox(height: 25 * y),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.cyan,
                                  fixedSize: Size(190 * x, 68 * y),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  )),
                              child: Text(
                                'Back',
                                style: TextStyle(
                                    fontSize: 36 * y, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ))),
        ));
  }
}
