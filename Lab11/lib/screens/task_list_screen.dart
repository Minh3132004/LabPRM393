import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../repositories/task_repository.dart';
import 'task_detail_screen.dart';

class TaskListScreen extends StatefulWidget {
  final TaskRepository repository;
  const TaskListScreen({super.key, required this.repository});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TextEditingController _controller = TextEditingController();

  void _addTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        widget.repository.addTask(
          Task(id: DateTime.now().toString(), title: _controller.text),
        );
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final tasks = widget.repository.tasks;

    return Scaffold(
      appBar: AppBar(title: const Text("Taskly")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    key: const Key('addTaskField'),
                    controller: _controller,
                    decoration: const InputDecoration(hintText: "Enter task title"),
                  ),
                ),
                IconButton(
                  key: const Key('addTaskButton'),
                  icon: const Icon(Icons.add),
                  onPressed: _addTask,
                ),
              ],
            ),
          ),
          Expanded(
            child: tasks.isEmpty
                ? const Center(child: Text("No tasks yet. Add one!"))
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return ListTile(
                        key: Key('task_${task.id}'),
                        title: Text(task.title),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: task.isCompleted,
                              onChanged: (val) {
                                setState(() => task.toggle());
                              },
                            ),
                            IconButton(
                              key: Key('deleteTaskButton_${task.id}'),
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  widget.repository.deleteTask(task.id);
                                });
                              },
                            ),
                          ],
                        ),
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskDetailScreen(
                                task: task,
                                repository: widget.repository,
                              ),
                            ),
                          );
                          setState(() {}); // Refresh list after returning
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
