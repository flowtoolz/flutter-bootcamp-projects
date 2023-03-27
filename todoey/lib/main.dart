import 'package:flowlist/screens/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flowlist/screens/task.dart';

void main() {
  runApp(const FlowlistApp());
}

class FlowlistApp extends StatelessWidget {
  const FlowlistApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskList>(
      create: (context) => TaskList(),
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light().copyWith(
            primary: Colors.lightBlueAccent,
            onPrimary: Colors.white,
            secondary: Colors.lightBlueAccent,
            onSecondary: Colors.white,
          )
        ),
        home: const TaskScreen(),
      ),
    );
  }
}


