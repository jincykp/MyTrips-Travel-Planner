import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_trips/database/functions/memories_db_functions.dart';
import 'package:my_trips/database/model/memories_model.dart';

class MemoryFullview extends StatefulWidget {
  final MemoryModel fullview;
  int id;
  MemoryFullview({super.key, required this.fullview, required this.id});

  @override
  State<MemoryFullview> createState() => _MemoryFullviewState();
}

class _MemoryFullviewState extends State<MemoryFullview> {
  var memoryListss;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    memoryListss = widget.fullview;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 6, 6, 37),
          foregroundColor: Colors.white,
          title: Text(
            "MEMORY DETAILS",
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Color.fromARGB(255, 156, 156, 192),
              // elevation: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                width: 450,
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      memoryListss.MemoryImage == null
                          ? Container(
                              height: 100, width: 400, child: Icon(Icons.image))
                          : Container(
                              width: 350,
                              height: 190,
                              child: memoryListss.MemoryImage != null
                                  ? Image.file(
                                      File(memoryListss.MemoryImage),
                                      fit: BoxFit.cover,
                                    )
                                  : Container()),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              "Trip Name:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            memoryListss.MemoryTripName,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 150,
                          ),
                          IconButton(
                              onPressed: () {
                                deleteAlertDialog(context, memoryListss.id);
                                //Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Color.fromARGB(255, 143, 36, 28),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "Trip Date:",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            memoryListss.MemoryDate,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "Trip Experience:",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            memoryListss.MemoryExperience,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

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
