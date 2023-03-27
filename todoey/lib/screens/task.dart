import 'dart:collection';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class TaskWidget extends StatelessWidget {

  TaskWidget({super.key, required this.taskIndex, required String initialText}) {
    editingController  = TextEditingController(text: initialText);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () {
        final taskList = Provider.of<TaskList>(context, listen: false);
        taskList.removeTask(taskIndex: taskIndex);
      },
      horizontalTitleGap: 0,
      leading: Checkbox(
        onChanged: (newValue) {
          if (newValue == null) { return; }
          final taskList = Provider.of<TaskList>(context, listen: false);
          taskList.setTaskIsChecked(taskIndex: taskIndex, isChecked: newValue);
        },
        value: getTask(context).isChecked,
      ),
      title: TextField(
        style: TextStyle(
          fontSize: 15,
          decoration: getTask(context).isChecked ? TextDecoration.lineThrough : null,
        ),
        decoration: null,
        controller: editingController,
        onChanged: (newText) {
          final taskList = Provider.of<TaskList>(context, listen: false);
          taskList.setTaskText(taskIndex: taskIndex, text: newText);
        },
      )
    );
  }

  Task getTask(BuildContext context) => Provider.of<TaskList>(context).tasks[taskIndex];

  late final TextEditingController editingController;
  late final int taskIndex;
}

class TaskList extends ChangeNotifier {

  add(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  removeTask({required int taskIndex}) {
    if (taskIndex >= _tasks.length) { return; }
    _tasks.removeAt(taskIndex);
    notifyListeners();
  }

  setTaskIsChecked({required int taskIndex, required bool isChecked}) {
    if (taskIndex >= _tasks.length) { return; }
    bool isChange = _tasks[taskIndex].isChecked != isChecked;
    _tasks[taskIndex].isChecked = isChecked;
    if (isChange) { notifyListeners(); }
  }

  setTaskText({required int taskIndex, required String text}) {
    if (taskIndex >= _tasks.length) { return; }
    bool isChange = _tasks[taskIndex].text != text;
    _tasks[taskIndex].text = text;
    if (isChange) { notifyListeners(); }
  }

  int get length { return _tasks.length; }

  UnmodifiableListView<Task> get tasks { 
    return UnmodifiableListView(_tasks);
  }

  final List<Task> _tasks = [
    Task(text: 'item 1', isChecked: false),
    Task(text: 'item 2', isChecked: false),
    Task(text: 'item 3', isChecked: true),
  ];
}

class Task {
  Task({required this.text, this.isChecked = false});

  String text;
  bool isChecked;
}