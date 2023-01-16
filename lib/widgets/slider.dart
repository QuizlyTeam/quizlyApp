import 'package:flutter/material.dart';

class QuizlySlider extends StatefulWidget {
  const QuizlySlider({super.key});

  @override
  State<QuizlySlider> createState() => _QuizlySlider();
}

///Widget that creates a slider used in settings
class _QuizlySlider extends State<QuizlySlider> {
  double currentValue = 50;

  @override
  Widget build(BuildContext context) {
    double y = MediaQuery.of(context).size.height / 866.2857142857143;
    return MediaQuery(
        data: const MediaQueryData(),
        child: Directionality(
            textDirection: TextDirection.ltr,
            child: Material(
                color: const Color(0xFFE2E2E2),
                child: SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 20 * y,

                      ///Thumb
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 12,
                      ),

                      ///Track
                      activeTrackColor: Colors.cyan,
                      inactiveTrackColor: const Color(0xFFA4A4A4),
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
