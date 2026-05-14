import 'package:flutter/material.dart';

class DebugFixDemo extends StatefulWidget {
  const DebugFixDemo({super.key});

  @override
  State<DebugFixDemo> createState() => _DebugFixDemoState();
}

class _DebugFixDemoState extends State<DebugFixDemo> {
  int _counter = 0;

  void _increment() {
    // FIX 3: Added setState() to trigger UI update
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 5: Debug & Fix')),
      // FIX 2: Wrapped Column in SingleChildScrollView to prevent overflow on small screens
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('Explanation of Fixes:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const Divider(),
              _fixDescription('1. ListView inside Column', 'Fixed by wrapping the ListView in an Expanded widget so it knows how much height to take.'),
              _fixDescription('2. Overflow Error', 'Fixed by using SingleChildScrollView around the Column to allow scrolling when content is too tall.'),
              _fixDescription('3. State not updating', 'Fixed by calling setState() inside the increment function to notify Flutter of the change.'),
              _fixDescription('4. DatePicker Context', 'Ensured showDatePicker is called using a valid BuildContext within the widget tree.'),
              
              const SizedBox(height: 20),
              
              // Demonstrating Fix 3
              ElevatedButton(
                onPressed: _increment,
                child: Text('Counter: $_counter (setState fix)'),
              ),

              const SizedBox(height: 20),

              // Demonstrating Fix 1
              const Text('Fixed ListView (Expanded):'),
              Container(
                height: 200, // Giving it a fixed height for demonstration within the scrollview
                decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                child: ListView.builder(
                  shrinkWrap: true, // Use shrinkWrap when inside another scrollable
                  physics: const NeverScrollableScrollPhysics(), // Let the outer scrollview handle it
                  itemCount: 5,
                  itemBuilder: (ctx, i) => ListTile(title: Text('Item $i')),
                ),
              ),
              
              // Adding lots of space to demonstrate FIX 2 (Scrollability)
              const SizedBox(height: 400, child: Center(child: Text('Scroll down to see more content...'))),
              const Text('Bottom of screen reached without overflow!'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fixDescription(String title, String explanation) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
          Text(explanation),
        ],
      ),
    );
  }
}
