import 'package:flutter/material.dart';

class LayoutBasicsDemo extends StatelessWidget {
  const LayoutBasicsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for ListView
    final List<String> movies = [
      'Inception', 'Interstellar', 'The Dark Knight', 
      'Tenet', 'The Prestige', 'Dunkirk', 'Memento'
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 3: Layout Basics')),
      body: Column(
        children: [
          // Section 1: Header using Column and Row
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Movies Collection',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Top Rated Movies', style: TextStyle(color: Colors.grey)),
                    TextButton(onPressed: () {}, child: const Text('See All')),
                  ],
                ),
              ],
            ),
          ),

          // Section 2: Spacing and ListView
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Suggested for you:', style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 8),

          // Expanded ensures ListView fits within the remaining Column space
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0), // Spacing of 12px
                  child: ListTile(
                    tileColor: Colors.blue.withOpacity(0.1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: Text(movies[index]),
                    trailing: const Icon(Icons.play_circle_outline),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
