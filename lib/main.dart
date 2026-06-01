import 'package:flutter/material.dart';
import 'input_controls_demo.dart';

void main() {
  runApp(const MyApp());
}

// Hàm main dùng để chạy thử Exercise 2
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InputControlsDemo(),
    );
  }
}