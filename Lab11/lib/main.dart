import 'package:flutter/material.dart';
import 'repositories/task_repository.dart';
import 'screens/task_list_screen.dart';

void main() {
  final repository = TaskRepository();
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final TaskRepository repository;
  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taskly',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: TaskListScreen(repository: repository),
    );
  }
}
