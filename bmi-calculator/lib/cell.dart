import 'package:flutter/material.dart';

class Cell extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isActive ? activeColor : inactiveColor,
      ),
    );
  }

  Cell({this.child, required this.isActive});

  final Widget? child;

  final bool isActive;

  static const activeColor = Color(0xff1d1e33);
  static const inactiveColor = Color(0xff111328);
}