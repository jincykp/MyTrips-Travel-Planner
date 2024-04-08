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
    updateMemories();
    memoryList = memoryNotifier.value;
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
        //mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ValueListenableBuilder<List<MemoryModel>>(
              valueListenable: memoryNotifier,
              builder: (context, memoryList, child) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    MemoryModel memory = memoryList[index];
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MemoryFullview(
                                        fullview: memoryList[index],
                                      )));
                        },
                        child: Container(
                          height: 170,
                          width: 80,
                          // color: Color.fromARGB(255, 120, 171, 212),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(File(memory.MemoryImage!)),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: memoryList.length,
                );
              },
            ),
          ),
          // SizedBox(width: 500),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddMemoriesScreen()));
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Color.fromARGB(255, 6, 6, 37),
          )
        ],
      ),
    );
  }
}
