import 'package:flutter/material.dart';
import 'package:quizly_app/widgets/header.dart';
import 'package:quizly_app/widgets/slider.dart';

class QuizlySlider extends StatefulWidget {
  const QuizlySlider({super.key});

  @override
  State<QuizlySlider> createState() => _QuizlySlider();
}

class _QuizlySlider extends State<QuizlySlider> {
  double currentValue = 50;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: const MediaQueryData(),
        child: Directionality(
            textDirection: TextDirection.ltr,
            child: Material(
                color: const Color(0xFFE2E2E2),
                child: SliderTheme(
                    data: const SliderThemeData(
                      trackHeight: 20,

                      ///Thumb
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 12,
                      ),

                      ///Track
                      activeTrackColor: Colors.cyan,
                      inactiveTrackColor: Color(0xFFA4A4A4),
                    ),
                    child: Slider(
                        key: const Key('suwak'),
                        value: currentValue,
                        max: 100,
                        onChanged: (double value) {
                          setState(() {
                            currentValue = value;
                          });
                        })))));
  }
}
