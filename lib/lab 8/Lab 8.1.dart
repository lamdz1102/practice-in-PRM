import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Lab81SimpleGetScreen extends StatefulWidget {
  const Lab81SimpleGetScreen({super.key});

  @override
  State<Lab81SimpleGetScreen> createState() => _Lab81SimpleGetScreenState();
}

class _Lab81SimpleGetScreenState extends State<Lab81SimpleGetScreen> {
  bool _isLoading = false;
  String? _firstTitle;
  String? _errorMessage;

  Future<void> _fetchPosts() async {
    setState(() {
      _isLoading = true;
      _firstTitle = null;
      _errorMessage = null;
    });

    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);

        setState(() {
          _firstTitle = jsonList[0]['title'];
        });
      } else {
        setState(() {
          _errorMessage = 'Request failed: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
    } else if (_errorMessage != null) {
      content = Center(
        child: Text(
          _errorMessage!,
          textAlign: TextAlign.center,
        ),
      );
    } else if (_firstTitle != null) {
      content = Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'First post title:\n\n$_firstTitle',
          style: const TextStyle(fontSize: 18),
        ),
      );
    } else {
      content = const Center(child: Text('No data'));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 8.1 - Simple GET'),
        centerTitle: true,
      ),
      body: content,
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchPosts,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}