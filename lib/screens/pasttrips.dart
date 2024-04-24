import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_trips/database/functions/trip_db_functions.dart';
import 'package:my_trips/database/model/trip_model.dart';
import 'package:my_trips/screens/fullviewof_past.dart';

class PastTripScreen extends StatefulWidget {
  const PastTripScreen({super.key});

  @override
  State<PastTripScreen> createState() => _PastTripScreenState();
}

class _PastTripScreenState extends State<PastTripScreen> {
  late List<TripModel> tripslist = [];

  @override
  void initState() {
    tripslist = tripListNotifier.value
        .where((trip) => trip.enddate!.isBefore(DateTime.now()))
        .toList();
    // TODO: implement initState
    super.initState();
  }

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
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<List<TripModel>>(
              valueListenable: tripListNotifier,
              builder: (context, tripList, _) {
                if (tripslist.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      var trip = tripslist[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          child: Card(
                            color: Color.fromARGB(255, 119, 71, 113),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 10),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PastFullView(trips: trip)));
                              },
                              leading: trip.image == ''
                                  ? Container(
                                      width: 100,
                                      height: 130,
                                      //color: Colors.white,
                                      child: Icon(Icons.trip_origin),
                                    )
                                  : Container(
                                      width: 100,
                                      height: 130,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Expanded(
                                          child: Image.file(
                                            File(trip.image!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                              title: Text(
                                "${trip.destination}",
                                style: TextStyle(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                "${trip.tripname}",
                                style: TextStyle(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                              // trailing: IconButton(
                              //   onPressed: () {
                              //     deleteAlertDialog(
                              //         context, tripList[index].id!);
                              //   },
                              //   icon: Icon(
                              //     Icons.delete,
                              //     color: Colors.red,
                              //   ),
                              // ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: tripslist.length,
                  );
                } else {
                  return Center(
                    child: Text(
                      "No Trips",
                      style: TextStyle(
                          color: Color.fromARGB(255, 6, 6, 37),
                          fontWeight: FontWeight.bold),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
