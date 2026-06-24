import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Lab93 extends StatefulWidget {
  const Lab93({super.key});

  @override
  State<Lab93> createState() => _Lab93State();
}

class _Lab93State extends State<Lab93> {
  List items = [];
  List filtered = [];

  final ctrl = TextEditingController();
  final searchCtrl = TextEditingController();

  Future<File> file() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/crud.json');
  }

  Future<void> load() async {
    final f = await file();
    if (!await f.exists()) return;

    final data = json.decode(await f.readAsString());
    setState(() {
      items = data;
      filtered = data;
    });
  }

  Future<void> save() async {
    final f = await file();
    await f.writeAsString(json.encode(items));
  }

  void add() {
    items.add({"id": DateTime.now().millisecondsSinceEpoch, "name": ctrl.text});
    ctrl.clear();
    save();
    search(searchCtrl.text);
  }

  void delete(int index) {
    filtered.removeAt(index);
    items = filtered;
    save();
    setState(() {});
  }

  void search(String key) {
    setState(() {
      filtered = items
          .where((e) => e['name'].toLowerCase().contains(key.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lab 9.3 CRUD")),
      body: Column(
        children: [
          TextField(
            controller: searchCtrl,
            onChanged: search,
            decoration: const InputDecoration(hintText: "Search"),
          ),
          Row(
            children: [
              Expanded(child: TextField(controller: ctrl)),
              IconButton(onPressed: add, icon: const Icon(Icons.add))
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (_, i) {
                return ListTile(
                  title: Text(filtered[i]['name']),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => delete(i),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}