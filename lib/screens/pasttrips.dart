import 'package:flutter/material.dart';

class PastTripScreen extends StatelessWidget {
  const PastTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          "PAST TRIPS",
        ),
        backgroundColor: Color.fromARGB(255, 6, 6, 37),
      ),
    );
  }
}
