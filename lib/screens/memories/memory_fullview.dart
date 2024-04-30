import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_trips/database/model/memories_model.dart';
import 'package:my_trips/screens/memories/edit_memories.dart';
import 'package:my_trips/screens/memories/one_memory.dart';

class MemoryFullview extends StatefulWidget {
  final MemoryModel fullview;

  //List<String> imagePath;
  MemoryFullview({super.key, required this.fullview});

  @override
  State<MemoryFullview> createState() => _MemoryFullviewState();
}

class _MemoryFullviewState extends State<MemoryFullview> {
  late MemoryModel memoryListss;
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
                    //  margin: EdgeInsets.all(8),
                    //color: Color.fromARGB(255, 156, 156, 192),
                    // elevation: 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Container(
                      width: 500,
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
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: RichText(
                                    // overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                        text: 'Trip Name:   ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 20),
                                        children: [
                                          TextSpan(
                                            text: memoryListss.MemoryTripName!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 20),
                                          ),
                                        ]),
                                  ),
                                ),
                                SizedBox(width: 20),
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => EditMemory(
                                                  mEdit: memoryListss,
                                                  id: memoryListss.id!))).then(
                                          (value) {
                                        memoryListss = value;
                                        setState(() {});
                                      });
                                    },
                                    icon: Icon(Icons.edit))
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: RichText(
                                text: TextSpan(
                                    text: 'Trip Date:   ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 20),
                                    children: [
                                      TextSpan(
                                        text: memoryListss.MemoryDate!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 20),
                                      )
                                    ]),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: RichText(
                                text: TextSpan(
                                    text: 'Trip Experience:   ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 20),
                                    children: [
                                      TextSpan(
                                        text: memoryListss.MemoryExperience!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 20),
                                      )
                                    ]),
                              ),
                            ),
                            SizedBox(height: 20),
                            Expanded(
                                child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            mainAxisSpacing: 5,
                                            crossAxisSpacing: 5),
                                    itemCount: memoryListss.MemoryImage?.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailView(
                                                          imagePath: memoryListss
                                                                  .MemoryImage![
                                                              index])));
                                        },
                                        child: Image.file(
                                          File(
                                              memoryListss.MemoryImage![index]),
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    }))
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
