import 'style.dart';
import 'package:flutter/material.dart';
import 'input_page.dart';

void main() => runApp(BMICalculator());

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        sliderTheme: SliderTheme.of(context).copyWith(
          activeTrackColor: Colors.white,
          inactiveTrackColor: Color(0xff8d8e98),
          thumbColor: Color(0xffeb1555),
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15),
          overlayShape: RoundSliderOverlayShape(overlayRadius: 30),
          overlayColor: Color(0x29eb1555),
        ),
        scaffoldBackgroundColor: kBackgroundColor,
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: kBackgroundColor,
          onPrimary: Colors.white,
          secondary: kBackgroundColor,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: kBackgroundColor,
          onBackground: Colors.white,
          surface: kBackgroundColor,
          onSurface: Colors.white,
        ),
      ),
      home: InputPage(),
    );
  }
}
