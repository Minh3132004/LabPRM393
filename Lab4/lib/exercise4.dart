import 'package:flutter/material.dart';

class AppStructureDemo extends StatelessWidget {
  const AppStructureDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. AppBar
      appBar: AppBar(
        title: const Text('Exercise 4: App Structure'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      
      // 2. Body
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.style, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            Text(
              'Complete App Structure',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'This screen demonstrates Scaffold components like AppBar, Body, and FloatingActionButton, as well as Theme usage.',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),

      // 3. FloatingActionButton
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('FAB Tapped!')),
          );
        },
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ),
    );
  }
}
