import 'package:flowlist/screens/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: SafeArea(
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context, 
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: AddTaskDialog(),
                )
              )
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
      body: Consumer<TaskList>(
        builder: (context, taskList, child) {
          return SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30,
                        child: Icon(
                          Icons.list,
                          size: 40,
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Flowlist',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${taskList.length} Tasks',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20), 
                        topRight: Radius.circular(20)
                      ),
                    ),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        if (index >= taskList.length) { return null; }
                        return TaskWidget(
                          taskIndex: index,
                          initialText: taskList.tasks[index].text
                        );
                      },
                      itemCount: taskList.length,
                    )
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class AddTaskDialog extends StatelessWidget {
  AddTaskDialog({super.key});

  final textController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), 
            topRight: Radius.circular(20)
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Colors.lightBlueAccent,
              ),
            ),
            TextField(
              textAlign: TextAlign.center,
              autofocus: true,
              controller: textController,
              onChanged: (newText) {},
              onSubmitted: (currentText) {
                addTask(context: context, text: currentText);
              },
            ),
            const SizedBox(height: 20),
            MaterialButton(
              color: Colors.lightBlueAccent,
              child: const Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),            
              onPressed: () {
                addTask(context: context, text: textController.text);
              },
            ),
          ],
        ),
      ),
    );
  }

  addTask({required BuildContext context, required String text}) {
    Navigator.pop(context);
                
    // listening here would throw exceptions
    Provider.of<TaskList>(context, listen: false).add(Task(text: text));
  }
}