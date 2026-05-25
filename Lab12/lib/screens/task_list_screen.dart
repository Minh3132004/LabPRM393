import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task_model.dart';
import '../widgets/task_tile.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Exercise 12.2: Pre-caching image
    precacheImage(const AssetImage('assets/images/task_icon.png'), context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Taskly - Optimized")),
      body: Column(
        children: [
          // Exercise 12.2: Displaying optimized image
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Image.asset(
              'assets/images/task_icon.png',
              width: 100,
              height: 100,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.task, size: 100),
            ),
          ),
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
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      Provider.of<TaskProvider>(context, listen: false)
                          .addTask(_controller.text);
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Selector<TaskProvider, List<Task>>(
              selector: (context, provider) => provider.tasks,
              builder: (context, tasks, child) {
                if (tasks.isEmpty) {
                  return const Center(child: Text("No tasks yet. Add one!"));
                }
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return TaskTile(task: tasks[index]);
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
