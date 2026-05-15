import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const JsonStorageApp());
}

class JsonStorageApp extends StatelessWidget {
  const JsonStorageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 9 - JSON Local Storage',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
