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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Calculate responsive grid
            double screenWidth = constraints.maxWidth;
            int crossAxisCount = screenWidth > 600 ? 3 : 2;
            double spacing = 12.0;
            double availableWidth =
                screenWidth - (spacing * (crossAxisCount - 1));
            double cardWidth = availableWidth / crossAxisCount;
            double childAspectRatio =
                cardWidth / (cardWidth * 1.1); // Slightly taller cards

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: spacing,
                crossAxisSpacing: spacing,
                childAspectRatio: childAspectRatio,
              ),
              itemCount: memories.length,
              itemBuilder: (context, index) {
                return buildMemoryCard(memories[index]);
              },
            );
          },
        ),
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
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Memory folder icon with preview - Flexible sizing
                Flexible(
                  flex: 3,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 70,
                      maxHeight: 70,
                      minWidth: 50,
                      minHeight: 50,
                    ),
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
                            size: 32,
                          ),
                        ),
                        if (memory.MemoryImage != null &&
                            memory.MemoryImage!.isNotEmpty)
                          Positioned(
                            top: 6,
                            right: 6,
                            child: Container(
                              constraints: BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  '${memory.MemoryImage!.length}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),

                // Trip name - Flexible
                Flexible(
                  flex: 2,
                  child: Text(
                    memory.MemoryTripName ?? 'Unnamed Memory',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                // Date - Flexible
                if (memory.MemoryDate != null)
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        memory.MemoryDate!,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),

                SizedBox(height: 8),

                // Action buttons - Fixed size
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        constraints: BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                        padding: EdgeInsets.all(4),
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
                          size: 16,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        constraints: BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                        padding: EdgeInsets.all(4),
                        onPressed: () {
                          deleteAlertDialog(context, memory.id!);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red[300],
                          size: 16,
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
              Expanded(
                child: Text(
                  "Delete Memory",
                  style: TextStyle(
                    color: Color(0xFF1E3A8A),
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
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
