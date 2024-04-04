import 'package:flutter/material.dart';
import 'package:my_trips/screens/memories/add_memories.dart';

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
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  height: 200,
                  width: 200,
                  color: Colors.blue,
                );
              },
              itemCount: 5,
            )
            // SizedBox(
            //   height: 20,
            // ),
            // Container(
            //   height: 200,
            //   width: 300,
            //   color: Colors.black12,
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // Container(
            //   height: 200,
            //   width: 300,
            //   color: Colors.black12,
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // Container(
            //   height: 200,
            //   width: 300,
            //   color: Colors.black12,
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // Container(
            //   height: 200,
            //   width: 300,
            //   color: Colors.black12,
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // SizedBox(width: 500),
            // FloatingActionButton(
            //   onPressed: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => AddMemoriesScreen()));
            //   },
            //   child: Icon(
            //     Icons.add,
            //     color: Colors.white,
            //   ),
            //   backgroundColor: Color.fromARGB(255, 6, 6, 37),
            // )
          ],
        ),
      ),
    );
  }
}
