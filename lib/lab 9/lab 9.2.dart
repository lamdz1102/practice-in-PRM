import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Lab92 extends StatefulWidget {
  const Lab92({super.key});

  @override
  State<Lab92> createState() => _Lab92State();
}

class _Lab92State extends State<Lab92> {
  List items = [];
  final nameCtrl = TextEditingController();

  Future<File> getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/data.json');
  }

  Future<void> load() async {
    final file = await getFile();
    if (!await file.exists()) return;

    final data = await file.readAsString();
    setState(() {
      items = json.decode(data);
    });
  }

  Future<void> save() async {
    final file = await getFile();
    await file.writeAsString(json.encode(items));
  }

  void addItem() {
    items.add({
      "id": items.length + 1,
      "name": nameCtrl.text
    });

    nameCtrl.clear();
    save();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lab 9.2")),
      body: Column(
        children: [
          TextField(controller: nameCtrl),
          ElevatedButton(
            onPressed: addItem,
            child: const Text("Add"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (_, i) {
                return ListTile(
                  title: Text(items[i]['name']),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}