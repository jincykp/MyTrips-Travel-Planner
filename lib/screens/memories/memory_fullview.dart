import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_trips/database/model/memories_model.dart';
import 'package:my_trips/screens/memories/edit_memories.dart';
import 'package:my_trips/screens/memories/one_memory.dart';

class MemoryFullview extends StatefulWidget {
  final MemoryModel fullview;

  MemoryFullview({super.key, required this.fullview});

  @override
  State<MemoryFullview> createState() => _MemoryFullviewState();
}

class _MemoryFullviewState extends State<MemoryFullview> {
  late MemoryModel memoryListss;

  @override
  void initState() {
    super.initState();
    memoryListss = widget.fullview;
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
        "MEMORY DETAILS",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 1.2,
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditMemory(
                    mEdit: memoryListss,
                    id: memoryListss.id!,
                  ),
                ),
              ).then((value) {
                if (value != null) {
                  memoryListss = value;
                  setState(() {});
                }
              });
            },
            icon: Icon(Icons.edit, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Images Section First
              buildImagesSection(),
              SizedBox(height: 24),
              // Trip Details Section
              buildTripDetailsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImagesSection() {
    if (memoryListss.MemoryImage == null || memoryListss.MemoryImage!.isEmpty) {
      return Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF3B82F6).withOpacity(0.1),
              Color(0xFF1E40AF).withOpacity(0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Color(0xFF3B82F6).withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.photo_library_outlined,
                size: 50,
                color: Color(0xFF3B82F6).withOpacity(0.5),
              ),
              SizedBox(height: 12),
              Text(
                "No Images Added",
                style: TextStyle(
                  color: Color(0xFF3B82F6),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.photo_library,
                  color: Color(0xFF3B82F6),
                  size: 24,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Memory Photos",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A8A),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0xFF3B82F6).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    "${memoryListss.MemoryImage!.length} ${memoryListss.MemoryImage!.length == 1 ? 'Photo' : 'Photos'}",
                    style: TextStyle(
                      color: Color(0xFF3B82F6),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                // Calculate grid dimensions based on available width
                double availableWidth = constraints.maxWidth;
                int crossAxisCount = availableWidth > 400 ? 4 : 3;
                double spacing = 8.0;
                double itemWidth =
                    (availableWidth - (spacing * (crossAxisCount - 1))) /
                        crossAxisCount;
                double gridHeight =
                    ((memoryListss.MemoryImage!.length / crossAxisCount)
                                .ceil() *
                            itemWidth) +
                        ((memoryListss.MemoryImage!.length / crossAxisCount)
                                    .ceil() -
                                1) *
                            spacing;

                return Container(
                  height: gridHeight.clamp(100.0, 300.0),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: spacing,
                      crossAxisSpacing: spacing,
                      childAspectRatio: 1,
                    ),
                    itemCount: memoryListss.MemoryImage!.length,
                    itemBuilder: (context, index) {
                      return buildImageCard(memoryListss.MemoryImage![index]);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImageCard(String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailView(imagePath: imagePath),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              Image.file(
                File(imagePath),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: Icon(
                      Icons.broken_image,
                      color: Colors.grey[400],
                    ),
                  );
                },
              ),
              // Overlay for better tap indication
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.1),
                    ],
                  ),
                ),
              ),
              // Tap indicator
              Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.zoom_in,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTripDetailsSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Color(0xFF3B82F6),
                  size: 24,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Trip Information",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A8A),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Trip Name
            buildDetailItem(
              icon: Icons.location_on,
              label: "Trip Name",
              value: memoryListss.MemoryTripName ?? "Not specified",
            ),
            SizedBox(height: 16),

            // Trip Date
            buildDetailItem(
              icon: Icons.calendar_today,
              label: "Trip Date",
              value: memoryListss.MemoryDate ?? "Not specified",
            ),
            SizedBox(height: 16),

            // Trip Experience
            buildDetailItem(
              icon: Icons.description,
              label: "Trip Experience",
              value: memoryListss.MemoryExperience ?? "No experience shared",
              isExpanded: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
    bool isExpanded = false,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFF3B82F6).withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color(0xFF3B82F6).withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Color(0xFF3B82F6),
                size: 20,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3B82F6),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF1E3A8A),
              fontWeight: FontWeight.w500,
              height: isExpanded ? 1.4 : 1.2,
            ),
            maxLines: isExpanded ? null : 2,
            overflow: isExpanded ? null : TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
