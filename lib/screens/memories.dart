import 'package:flutter/material.dart';

class MemoryScreen extends StatelessWidget {
  const MemoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          "MEMORIES",
        ),
        backgroundColor: Color.fromARGB(255, 6, 6, 37),
      ),
    );
  }
}
