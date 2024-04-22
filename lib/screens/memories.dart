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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: ValueListenableBuilder<List<MemoryModel>>(
                valueListenable: memoryNotifier,
                builder: (context, value, child) => GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5),
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Color.fromARGB(255, 237, 240, 243),
                        child: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MemoryFullview(
                                                        fullview:
                                                            value[index])));
                                      },
                                      icon: Icon(
                                        Icons.folder,
                                        color: Colors.amber,
                                        size: 80,
                                      )),
                                  Text(value[index].MemoryTripName ??
                                      'unnamed '),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.delete),
                                  )
                                ],
                              ),
                            ),
                          ),
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
      ),
    );
  } //-----------------------------delete------------

  deleteAlertDialog(BuildContext context, int id) {
    Widget cancelButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text("Cancel"),
    );
    Widget continueButton = TextButton(
        onPressed: () {
          print(id);
          deleteMemory(id);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (context) => MemoryScreen()));
        },
        child: Text("Delete"));
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      title: Text("Delete This Memory"),
      content: Text("Do you want to delete this memory?"),
      actions: [cancelButton, continueButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
