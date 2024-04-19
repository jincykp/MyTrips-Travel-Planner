import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_trips/database/functions/memories_db_functions.dart';
import 'package:my_trips/database/model/memories_model.dart';
import 'package:my_trips/screens/memories/add_memories.dart';
import 'package:my_trips/screens/memories/memory_fullview.dart';

class MemoryScreen extends StatefulWidget {
  const MemoryScreen({super.key});

  @override
  State<MemoryScreen> createState() => _MemoryScreenState();
}

class _MemoryScreenState extends State<MemoryScreen> {
  late List<MemoryModel> memoryList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    memoryNotifier.addListener(() {
      setState(() {
        memoryList = memoryNotifier.value;
      });
    });
    updateMemories();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          "MEMORIES",
        ),
        backgroundColor: Color.fromARGB(255, 6, 6, 37),
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<List<MemoryModel>>(
              valueListenable: memoryNotifier,
              builder: (context, value, child) => GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 5.0,
                      crossAxisSpacing: 5.0),
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MemoryFullview(
                                    fullview: value[index],
                                    id: value[index].id ?? 0)));
                      },
                      child: Image.file(
                        File(value[index].MemoryImage!),
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddMemoriesScreen()));
                    if (result != null && result is MemoryModel) {
                      setState(() {
                        memoryList.add(result);
                      });
                    }
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  backgroundColor: Color.fromARGB(255, 6, 6, 37),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
