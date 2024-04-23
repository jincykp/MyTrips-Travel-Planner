import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:my_trips/database/functions/trip_db_functions.dart';
import 'package:my_trips/database/model/trip_model.dart';

class PastFullView extends StatefulWidget {
  final TripModel trips;
  const PastFullView({super.key, required this.trips});

  @override
  State<PastFullView> createState() => _PastFullViewState();
}

class _PastFullViewState extends State<PastFullView> {
  var tripListss;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tripListss = widget.trips;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          "TRIP DETAILS",
        ),
        backgroundColor: Color.fromARGB(255, 6, 6, 37),
      ),
      body: Center(
        child: Card(
          color: Color.fromARGB(255, 119, 71, 113),
          elevation: 50,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: 350,
            height: 600,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(
                    height: 10,
                  ),
                  tripListss.image == null
                      ? Container(
                          height: 40,
                          width: 400,
                          child: Icon(Icons.trip_origin))
                      : Container(
                          width: 400,
                          height: 80,
                          child: tripListss.image != null
                              ? Image.file(File(tripListss.image))
                              : Container()),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(
                        width: 130,
                        child: Text(
                          "Detination :",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          tripListss.destination,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      SizedBox(
                        width: 130,
                        child: Text("Start Date :",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      Text(
                          DateFormat('dd-MM-yyyy').format(tripListss.startdate),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      SizedBox(
                        width: 130,
                        child: Text(
                          "End Date   :",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(DateFormat('dd-MM-yyyy').format(tripListss.enddate),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      SizedBox(
                        width: 130,
                        child: Text(
                          "Trip Name:",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          tripListss.tripname,
                          style: TextStyle(
                              color: Colors.white,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      SizedBox(
                        width: 130,
                        child: Text(
                          "Description:",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          tripListss.description,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 233, 224, 224),
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
