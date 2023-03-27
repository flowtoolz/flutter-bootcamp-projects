import 'style.dart';
import 'package:flutter/material.dart';

class CallToActionButton extends StatelessWidget {

  const CallToActionButton({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        child: SafeArea(
          child: Center(
            child: Text(
              title.toUpperCase(), 
              style: kLargeButtonStyle)
          ),
        ),
        color: kBottomBarColor,
        margin: EdgeInsets.only(top: 15),
        height: bottomBarHeight,
      ),
    );
  }

  final String title;
  final Function onPressed;

  static const bottomBarHeight = 80.0;
}