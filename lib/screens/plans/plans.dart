// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:my_trips/database/model/trip_model.dart';
// import 'package:my_trips/screens/plans/addplan.dart';

// class AddPlanScreen extends StatefulWidget {
//   TripModel model;

//   AddPlanScreen({super.key, required this.model, required this.id});

//   @override
//   State<AddPlanScreen> createState() => _AddPlanScreenState();
// }

// class _AddPlanScreenState extends State<AddPlanScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 7, 7, 19),
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 6, 6, 37),
//         foregroundColor: Colors.white,
//         title: Text("ADD PLANS"),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             //crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Row(
//                 children: [
//                   IconButton(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.note_add,
//                       color: Colors.purple,
//                     ),
//                     iconSize: 25,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       print("taped");
//                     },
//                     child: Text(
//                       "Notes",
//                       style: TextStyle(color: Colors.white, fontSize: 20),
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(height: 10),
//               Divider(),
//               Row(
//                 children: [
//                   IconButton(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.laptop,
//                       color: Colors.purple,
//                     ),
//                     iconSize: 25,
//                   ),
//                   GestureDetector(
//                     onTap: () {},
//                     child: Text(
//                       "Meeting",
//                       style: TextStyle(color: Colors.white, fontSize: 20),
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(height: 10),
//               Divider(),
//               Row(
//                 children: [
//                   IconButton(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.run_circle_outlined,
//                       color: Colors.purple,
//                     ),
//                     iconSize: 25,
//                   ),
//                   GestureDetector(
//                     onTap: () {},
//                     child: Text(
//                       "Activity",
//                       style: TextStyle(color: Colors.white, fontSize: 20),
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(height: 10),
//               Divider(),
//               Row(
//                 children: [
//                   IconButton(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.call,
//                       color: Colors.purple,
//                     ),
//                     iconSize: 25,
//                   ),
//                   GestureDetector(
//                     onTap: () {},
//                     child: Text(
//                       "Call",
//                       style: TextStyle(color: Colors.white, fontSize: 20),
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(height: 10),
//               Divider(),
//               Row(
//                 children: [
//                   IconButton(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.celebration,
//                       color: Colors.purple,
//                     ),
//                     iconSize: 25,
//                   ),
//                   GestureDetector(
//                     onTap: () {},
//                     child: Text(
//                       "Functions",
//                       style: TextStyle(color: Colors.white, fontSize: 20),
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(height: 10),
//               Divider(),
//               SizedBox(height: 150),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   FloatingActionButton(
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => addPlanScreen()));
//                     },
//                     child: Icon(
//                       Icons.add,
//                       color: Colors.white,
//                     ),
//                     backgroundColor: Colors.purple,
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
