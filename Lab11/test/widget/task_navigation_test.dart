import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab11/models/task_model.dart';
import 'package:lab11/repositories/task_repository.dart';
import 'package:lab11/screens/task_list_screen.dart';

void main() {
  testWidgets('Tapping a task should navigate to Detail screen', (WidgetTester tester) async {
    // Arrange
    final repository = TaskRepository();
    repository.addTask(Task(id: 'unique_id', title: 'Seeded Task'));

    await tester.pumpWidget(MaterialApp(home: TaskListScreen(repository: repository)));

    // Act: Tap the seeded task
    await tester.tap(find.text('Seeded Task'));
    await tester.pumpAndSettle(); // Wait for navigation animation

    // Assert
    expect(find.text("Task Detail"), findsOneWidget); // AppBar title
    expect(find.byKey(const Key('detailTitleField')), findsOneWidget); // TextField
  });
}
