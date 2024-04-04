import 'package:flutter/material.dart';

class AddMemoriesScreen extends StatefulWidget {
  const AddMemoriesScreen({super.key});

  @override
  State<AddMemoriesScreen> createState() => _AddMemoriesScreenState();
}

class _AddMemoriesScreenState extends State<AddMemoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 6, 6, 37),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 7, 7, 19),
      ),
    );
  }
}
