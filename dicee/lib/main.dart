import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text('Dicee'),
          backgroundColor: Colors.red,
        ),
        body: InteractiveDicePage(),
      ),
    ),
  );
}

class InteractiveDicePage extends StatefulWidget {
  const InteractiveDicePage({ Key? key }) : super(key: key);

  @override
  State<InteractiveDicePage> createState() => _InteractiveDicePageState();
}

class _InteractiveDicePageState extends State<InteractiveDicePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: TextButton(
              child: Image.asset('images/dice$leftNum.png'),
              onPressed: () {
                rollTheDice();
              },
            ),
          ),
          Expanded(
            child: TextButton(
              child: Image.asset('images/dice$rightNum.png'),
              onPressed: () {
                rollTheDice();
              },
            ),
          ),
        ],
      ),
    );
  }

  void rollTheDice() {
    setState(() {
      leftNum = Random().nextInt(6) + 1;
      rightNum = Random().nextInt(6) + 1;
    });
  }
  
  int leftNum = 1;
  int rightNum = 1;
}