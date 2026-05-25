import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab11/repositories/task_repository.dart';
import 'package:lab11/screens/task_list_screen.dart';

void main() {
  testWidgets('Full flow: Add → Navigate → Edit → Save → Verify', (WidgetTester tester) async {
    final repository = TaskRepository();
    await tester.pumpWidget(MaterialApp(home: TaskListScreen(repository: repository)));

    // 1. Add "Original title"
    await tester.enterText(find.byKey(const Key('addTaskField')), "Original title");
    await tester.tap(find.byKey(const Key('addTaskButton')));
    await tester.pump();

    // 2. Tap task to open detail
    await tester.tap(find.text("Original title"));
    await tester.pumpAndSettle();

    // 3. Edit to "Updated title"
    await tester.enterText(find.byKey(const Key('detailTitleField')), "Updated title");

    // 4. Save
    await tester.tap(find.byKey(const Key('saveTaskButton')));
    await tester.pumpAndSettle();

    // 5. Verify updated title appears in list
    expect(find.text("Updated title"), findsOneWidget);
    expect(find.text("Original title"), findsNothing);
  });
}
