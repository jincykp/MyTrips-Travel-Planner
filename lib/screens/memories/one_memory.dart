import 'dart:io';
import 'package:flutter/material.dart';

class DetailView extends StatefulWidget {
  final String imagePath;
  const DetailView({required this.imagePath});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
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
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: InteractiveViewer(
            maxScale: 15,
            minScale: 0.5,
            child: Center(
              child: Image.file(
                File(widget.imagePath),
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 50,
                          color: Colors.white70,
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Unable to load image",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
