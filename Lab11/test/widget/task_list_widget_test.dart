import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab11/repositories/task_repository.dart';
import 'package:lab11/screens/task_list_screen.dart';

void main() {
  testWidgets('Empty State should display specific text', (WidgetTester tester) async {
    final repository = TaskRepository();
    await tester.pumpWidget(MaterialApp(home: TaskListScreen(repository: repository)));

    expect(find.text("No tasks yet. Add one!"), findsOneWidget);
  });

  testWidgets('Adding a task should update UI', (WidgetTester tester) async {
    final repository = TaskRepository();
    await tester.pumpWidget(MaterialApp(home: TaskListScreen(repository: repository)));

    // Act: Enter text and tap add
    await tester.enterText(find.byKey(const Key('addTaskField')), "My New Task");
    await tester.tap(find.byKey(const Key('addTaskButton')));
    await tester.pump(); // Rebuild widget

    // Assert
    expect(find.text("My New Task"), findsOneWidget);
    expect(find.text("No tasks yet. Add one!"), findsNothing);
  });

  testWidgets('Adding multiple tasks should show both', (WidgetTester tester) async {
    final repository = TaskRepository();
    await tester.pumpWidget(MaterialApp(home: TaskListScreen(repository: repository)));

    // Add first task
    await tester.enterText(find.byKey(const Key('addTaskField')), "Task 1");
    await tester.tap(find.byKey(const Key('addTaskButton')));
    await tester.pump();

    // Add second task
    await tester.enterText(find.byKey(const Key('addTaskField')), "Task 2");
    await tester.tap(find.byKey(const Key('addTaskButton')));
    await tester.pump();

    // Assert
    expect(find.text("Task 1"), findsOneWidget);
    expect(find.text("Task 2"), findsOneWidget);
  });

  testWidgets('Deleting a task should update UI', (WidgetTester tester) async {
    final repository = TaskRepository();
    await tester.pumpWidget(MaterialApp(home: TaskListScreen(repository: repository)));

    // 1. Add a task
    await tester.enterText(find.byKey(const Key('addTaskField')), "Task to delete");
    await tester.tap(find.byKey(const Key('addTaskButton')));
    await tester.pump();
    expect(find.text("Task to delete"), findsOneWidget);

    // 2. Find and tap the delete button
    // Note: We use find.byIcon(Icons.delete) or the specific key we added
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();

    // 3. Assert it's gone
    expect(find.text("Task to delete"), findsNothing);
    expect(find.text("No tasks yet. Add one!"), findsOneWidget);
  });
}
