import 'package:flutter/material.dart';

import 'lab 7/lab 7.1.dart';
import 'lab 7/lab 7.2.dart';
import 'lab 7/lab 7.3.dart';
import 'lab 7/lab 7.4.dart';

void main() {
  runApp(const Lab7App());
}

class Lab7App extends StatelessWidget {
  const Lab7App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 7 - Forms and Validation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const Lab7HomeScreen(),
    );
  }
}

class Lab7HomeScreen extends StatelessWidget {
  const Lab7HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 7 - Forms and Validation'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Choose a lab exercise',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          _LabMenuCard(
            title: 'Lab 7.1',
            subtitle: 'Basic Registration Form',
            icon: Icons.assignment,
            screen: const Lab71BasicFormScreen(),
          ),

          _LabMenuCard(
            title: 'Lab 7.2',
            subtitle: 'Validation Rules & Password Strength',
            icon: Icons.verified_user,
            screen: const Lab72ValidationRulesScreen(),
          ),

          _LabMenuCard(
            title: 'Lab 7.3',
            subtitle: 'Focus & Keyboard Management',
            icon: Icons.keyboard,
            screen: const Lab73FocusKeyboardScreen(),
          ),

          _LabMenuCard(
            title: 'Lab 7.4',
            subtitle: 'Async Email Validation',
            icon: Icons.cloud_sync,
            screen: const Lab74AsyncValidationScreen(),
          ),
        ],
      ),
    );
  }
}

class _LabMenuCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget screen;

  const _LabMenuCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => screen,
            ),
          );
        },
      ),
    );
  }
}