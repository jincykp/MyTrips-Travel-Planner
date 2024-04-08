import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_trips/database/model/memories_model.dart';

class MemoryFullview extends StatefulWidget {
  final MemoryModel fullview;
  MemoryFullview({super.key, required this.fullview});

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
                          Text(
                            "Trip Name:",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            memoryListss.MemoryTripName,
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
}
