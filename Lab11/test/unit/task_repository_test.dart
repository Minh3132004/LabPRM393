import 'package:flutter_test/flutter_test.dart';
import 'package:lab11/models/task_model.dart';
import 'package:lab11/repositories/task_repository.dart';

void main() {
  group('TaskRepository Unit Tests', () {
    late TaskRepository repository;

    setUp(() {
      repository = TaskRepository();
    });

    test('addTask() should add a task to the list', () {
      // Arrange
      final task = Task(id: '1', title: 'New Task');

      // Act
      repository.addTask(task);

      // Assert
      expect(repository.tasks.length, 1);
      expect(repository.tasks[0].title, 'New Task');
    });

    test('deleteTask() should remove task by ID', () {
      // Arrange
      repository.addTask(Task(id: '1', title: 'Task 1'));
      repository.addTask(Task(id: '2', title: 'Task 2'));

      // Act
      repository.deleteTask('1');

      // Assert
      expect(repository.tasks.length, 1);
      expect(repository.tasks[0].id, '2');
    });

    test('updateTask() should change the title of an existing task', () {
      // Arrange
      repository.addTask(Task(id: '1', title: 'Old Title'));

      // Act
      repository.updateTask('1', 'Updated Title');

      // Assert
      expect(repository.tasks[0].title, 'Updated Title');
    });
  });
}
