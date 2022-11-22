import 'package:flutter/material.dart';
import '../widgets/slider.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          color: Colors.black,
          child: Center(
              child: Container(
                  width: 317,
                  height: 408,
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
                        height: 77,
                        width: 317,
                        decoration: const BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(45),
                            topRight: Radius.circular(45),
                            bottomLeft: Radius.circular(45),
                            bottomRight: Radius.circular(45),
                          ),
                        ),
                        child: const Center(
                            child: DefaultTextStyle(
                          style: TextStyle(
                              fontSize: 36,
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                          child: Text(
                            'Settings',
                            textDirection: TextDirection.ltr,
                          ),
                        )),
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          const DefaultTextStyle(
                            style: TextStyle(
                                fontSize: 36,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                            child: Text(
                              'Music',
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                          const QuizlySlider(),
                          const DefaultTextStyle(
                            style: TextStyle(
                                fontSize: 36,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                            child: Text(
                              'Sound',
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                          const QuizlySlider(),
                          const SizedBox(height: 25),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.cyan,
                                  fixedSize: const Size(190, 68),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  )),
                              child: const Text(
                                'Back',
                                style: TextStyle(
                                    fontSize: 36, color: Colors.white),
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
