import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../repositories/task_repository.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task task;
  final TaskRepository repository;

  const TaskDetailScreen({super.key, required this.task, required this.repository});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.task.title);
  }

  void _save() {
    widget.repository.updateTask(widget.task.id, _controller.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task Detail")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              key: const Key('detailTitleField'),
              controller: _controller,
              decoration: const InputDecoration(labelText: "Task Title"),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              key: const Key('saveTaskButton'),
              onPressed: _save,
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
