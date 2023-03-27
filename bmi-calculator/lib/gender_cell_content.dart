import 'style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class GenderCellContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            gender == Gender.male ? FontAwesomeIcons.mars : FontAwesomeIcons.venus,
            size: iconSize,
          ),
          SizedBox(height: 15),
          Text(
            gender == Gender.male ? "MALE" : "FEMALE", 
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  GenderCellContent({required this.gender, required this.onTap});

  final Gender gender;

  final Function onTap;

  static const iconSize = 80.0;
}

enum Gender { male, female }