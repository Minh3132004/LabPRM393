import 'package:flutter_test/flutter_test.dart';
import 'package:lab11/models/task_model.dart';

void main() {
  group('Task Model Tests', () {
    test('Default completed value should be false', () {
      // Arrange
      final task = Task(id: '1', title: 'Test Task');

      // Assert
      expect(task.isCompleted, false);
    });

    test('toggle() should switch true ↔ false', () {
      // Arrange
      final task = Task(id: '1', title: 'Test Task');

      // Act & Assert (Toggle to true)
      task.toggle();
      expect(task.isCompleted, true);

      // Act & Assert (Toggle back to false)
      task.toggle();
      expect(task.isCompleted, false);
    });
  });
}
