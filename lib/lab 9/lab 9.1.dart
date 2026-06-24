import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Lab91 extends StatefulWidget {
  const Lab91({super.key});

  @override
  State<Lab91> createState() => _Lab91State();
}

class _Lab91State extends State<Lab91> {
  List items = [];

  Future<void> loadJson() async {
    final String data =
    await rootBundle.loadString('assets/data/items.json');

    setState(() {
      items = json.decode(data);
    });
  }

  @override
  void initState() {
    super.initState();
    loadJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lab 9.1")),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (_, i) {
          return ListTile(
            title: Text(items[i]['name']),
            subtitle: Text("Price: ${items[i]['price']}"),
          );
        },
      ),
    );
  }
}