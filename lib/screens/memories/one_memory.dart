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
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 6, 6, 37),
        foregroundColor: Colors.white,
        title: Text(
          "MEMORY DETAILS",
        ),
      ),
      body: Center(
        child: Image.file(
          File(widget.imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
