import 'package:flutter/material.dart';
import 'task_model.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<Task> tasks = [
    Task(id: 1, title: 'Buy groceries'),
    Task(id: 2, title: 'Walk the dog'),
    Task(id: 3, title: 'Read a book'),
  ];

  void toggleComplete(int id) {
    setState(() {
      final task = tasks.firstWhere((task) => task.id == id);
      task.isCompleted = !task.isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(
              task.title,
              style: TextStyle(
                decoration:
                    task.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            trailing: Checkbox(
              value: task.isCompleted,
              onChanged: (_) => toggleComplete(task.id),
            ),
          );
        },
      ),
    );
  }
}
