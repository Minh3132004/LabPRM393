import '../models/task_model.dart';

class TaskRepository {
  final List<Task> _tasks = [];

  List<Task> get tasks => List.unmodifiable(_tasks);

  void addTask(Task task) {
    _tasks.add(task);
  }

  void deleteTask(String id) {
    _tasks.removeWhere((t) => t.id == id);
  }

  void updateTask(String id, String newTitle) {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      _tasks[index].title = newTitle;
    }
  }
}
