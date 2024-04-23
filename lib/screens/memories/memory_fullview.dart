import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_trips/database/functions/memories_db_functions.dart';
import 'package:my_trips/database/model/memories_model.dart';
import 'package:my_trips/screens/memories.dart';

class MemoryFullview extends StatefulWidget {
  final MemoryModel fullview;

  //List<String> imagePath;
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
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Color.fromARGB(255, 156, 156, 192),
                    // elevation: 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Container(
                      width: 450,
                      // height: 600,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
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
                                Expanded(
                                  child: Text(
                                    memoryListss.MemoryExperience,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Expanded(
                              child: Container(
                                child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 1),
                                    itemCount: memoryListss.MemoryImage.length,
                                    itemBuilder: (context, index) {
                                      print(memoryListss.MemoryImage[index]);
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Image.file(
                                          File(memoryListss.MemoryImage[index]),
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
