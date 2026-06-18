import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Lab83PostRequestScreen extends StatefulWidget {
  const Lab83PostRequestScreen({super.key});

  @override
  State<Lab83PostRequestScreen> createState() => _Lab83PostRequestScreenState();
}

class _Lab83PostRequestScreenState extends State<Lab83PostRequestScreen> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  bool _isLoading = false;
  String? _result;
  String? _errorMessage;

  Future<void> _createPost() async {
    final title = _titleController.text.trim();
    final body = _bodyController.text.trim();

    if (title.isEmpty || body.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter title and body'),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _result = null;
      _errorMessage = null;
    });

    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'title': title,
          'body': body,
          'userId': 1,
        }),
      );

      if (response.statusCode == 201) {
        setState(() {
          _result = response.body;
        });
      } else {
        throw Exception('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _retry() {
    _createPost();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final buttonChild = _isLoading
        ? const SizedBox(
      width: 18,
      height: 18,
      child: CircularProgressIndicator(strokeWidth: 2),
    )
        : const Text('Send POST');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 8.3 - POST Request'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _titleController,
              enabled: !_isLoading,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: _bodyController,
              enabled: !_isLoading,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Body',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: _isLoading ? null : _createPost,
              child: buttonChild,
            ),

            const SizedBox(height: 24),

            if (_errorMessage != null) ...[
              Text(
                'Error: $_errorMessage',
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: _isLoading ? null : _retry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],

            if (_result != null) ...[
              const Text(
                'Success response:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 8),
              SelectableText(_result!),
            ],
          ],
        ),
      ),
    );
  }
}