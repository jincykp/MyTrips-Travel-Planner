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
    super.initState();
    updateMemories();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A1A2E),
              Color(0xFF16213E),
              Color(0xFF0F3460),
            ],
          ),
        ),
      ),
      title: Text(
        "MEMORIES",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 1.2,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        Expanded(
          child: ValueListenableBuilder<List<MemoryModel>>(
            valueListenable: memoryNotifier,
            builder: (context, value, child) {
              if (value.isEmpty) {
                return buildNoMemoriesWidget();
              }
              return buildMemoryGrid(value);
            },
          ),
        ),
        buildFloatingActionButton(),
      ],
    );
  }

  Widget buildMemoryGrid(List<MemoryModel> memories) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemCount: memories.length,
        itemBuilder: (context, index) {
          return buildMemoryCard(memories[index]);
        },
      ),
    );
  }

  Widget buildMemoryCard(MemoryModel memory) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF3B82F6),
            Color(0xFF1E40AF),
            Color(0xFF1E3A8A),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MemoryFullview(fullview: memory),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Memory folder icon with preview
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          Icons.photo_library,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      if (memory.MemoryImage != null &&
                          memory.MemoryImage!.isNotEmpty)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                '${memory.MemoryImage!.length}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                // Trip name
                Text(
                  memory.MemoryTripName ?? 'Unnamed Memory',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                // Date
                if (memory.MemoryDate != null)
                  Text(
                    memory.MemoryDate!,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                SizedBox(height: 12),
                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MemoryFullview(fullview: memory),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.visibility,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        onPressed: () {
                          deleteAlertDialog(context, memory.id!);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red[300],
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNoMemoriesWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Color(0xFF3B82F6).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.photo_library,
              size: 50,
              color: Color(0xFF3B82F6).withOpacity(0.5),
            ),
          ),
          SizedBox(height: 24),
          Text(
            "No Memories Yet",
            style: TextStyle(
              color: Color(0xFF1E3A8A),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Text(
            "Start capturing your travel memories!",
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFloatingActionButton() {
    return Container(
      margin: EdgeInsets.all(16),
      child: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMemoriesScreen()),
          );
          if (result != null && result is MemoryModel) {
            setState(() {
              memoryList.add(result);
            });
          }
        },
        icon: Icon(Icons.add, color: Colors.white),
        label: Text(
          "Add Memory",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF1E3A8A),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  void deleteAlertDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red),
              SizedBox(width: 12),
              Text(
                "Delete Memory",
                style: TextStyle(
                  color: Color(0xFF1E3A8A),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            "Are you sure you want to delete this memory? This action cannot be undone.",
            style: TextStyle(color: Colors.grey[700]),
          ),
          actions: [
            TextButton(
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.grey[600]),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("Delete", style: TextStyle(color: Colors.white)),
              onPressed: () {
                deleteMemory(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
