import 'package:bmi_calculator/cell.dart';
import 'package:bmi_calculator/style.dart';
import 'package:flutter/material.dart';
import 'call_to_action_button.dart';
import 'package:bmi_calculator/bmi.dart';

class ResultPage extends StatelessWidget {

  ResultPage({required this.bmi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BMI Calculator')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: Text('Your Result', style: kNumberStyle),
            margin: EdgeInsets.symmetric(horizontal: 15),
          ),
          Expanded(
            child: Cell(
              isActive: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    bmi.judgement().toUpperCase(), 
                    style: TextStyle(
                      color: Color(0xff24d876),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    bmi.numberSring(), 
                    style: TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    bmi.hint(), 
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
          CallToActionButton(
            title: 'Adjust Inputs',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  final BodyMassIndex bmi;
}

