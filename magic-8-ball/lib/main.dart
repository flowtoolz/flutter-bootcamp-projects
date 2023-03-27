// import 'dart:js';

import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.blue,
      body: MainScreen(),
      appBar: AppBar(
        title: Text('Chrystal Ball AMA'),
        backgroundColor: Colors.blue.shade900,
      ),
    ),
  ),
);

class MainScreen extends StatefulWidget {
  const MainScreen({ Key? key }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TextButton(
          child: Image.asset("images/ball$ballNumber.png"),
          onPressed: () {
            setState(() {
              ballNumber = Random().nextInt(5) + 1;
            });
          },
        ),
      ),
    );
  }

  int ballNumber = 1;
}