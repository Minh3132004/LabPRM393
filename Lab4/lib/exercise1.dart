import 'package:flutter/material.dart';

class CoreWidgetsDemo extends StatelessWidget {
  const CoreWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 1: Core Widgets')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Headline Text
            const Text(
              'Welcome to Flutter UI',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),

            // 2. Icon using Material Icons
            const Row(
              children: [
                Icon(Icons.flutter_dash, size: 50, color: Colors.cyan),
                SizedBox(width: 10),
                Text('Flutter Dash Icon', style: TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 20),

            // 3. Image.network()
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => 
                    const Center(child: Text('Failed to load image')),
              ),
            ),
            const SizedBox(height: 20),

            // 4. Card containing a ListTile
            const Card(
              elevation: 4,
              child: ListTile(
                leading: CircleAvatar(child: Icon(Icons.person)),
                title: Text('User Profile Card'),
                subtitle: Text('This is a ListTile inside a Card widget.'),
                trailing: Icon(Icons.more_vert),
              ),
            ),
            
            const SizedBox(height: 20),
            const Text(
              'Explanation: This screen demonstrates the basic building blocks of a Flutter UI: text styling, icons, network images, and common list items.',
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
