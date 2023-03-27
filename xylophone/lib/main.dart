import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildKeyboardKey(index: 1, color: Colors.red),
              buildKeyboardKey(index: 2, color: Colors.orange),
              buildKeyboardKey(index: 3, color: Colors.yellow),
              buildKeyboardKey(index: 4, color: Colors.green),
              buildKeyboardKey(index: 5, color: Colors.teal),
              buildKeyboardKey(index: 6, color: Colors.blue),
              buildKeyboardKey(index: 7, color: Colors.purple),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildKeyboardKey({int index, Color color}) {
    return Expanded(
      child: TextButton(
        child: Container(
          color: color,
        ), 
        onPressed: () {
          playSound(index: index);
        },
      ),
    );
  }
}

void playSound({int index}) {
  final player = AudioCache();
  player.play('note$index.wav');
}