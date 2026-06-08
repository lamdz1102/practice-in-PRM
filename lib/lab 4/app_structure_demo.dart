import 'package:flutter/material.dart';

class AppStructureDemo extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const AppStructureDemo({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Thanh tiêu đề phía trên
      appBar: AppBar(
        title: const Text('Exercise 4 - App Structure'),

        // Nút chuyển Dark Mode đặt trên AppBar
        actions: [
          Row(
            children: [
              const Text('Dark'),
              Switch(
                value: isDarkMode,
                onChanged: onThemeChanged,
              ),
            ],
          ),
        ],
      ),

      // Nội dung chính của màn hình
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'This is a simple screen with theme toggle.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),

      // Nút nổi phía dưới bên phải
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Floating Action Button clicked'),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}