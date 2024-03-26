import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_trips/database/model/trip_model.dart';

class ViewTripDetails extends StatefulWidget {
  final TripModel trips;
  ViewTripDetails({super.key, required this.trips});

  @override
  State<ViewTripDetails> createState() => _ViewTripDetailsState();
}

class _ViewTripDetailsState extends State<ViewTripDetails> {
  var _tripLists;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tripLists = widget.trips;
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
          color: Color.fromARGB(255, 6, 6, 37),
          elevation: 50,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: 350,
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  _tripLists.image == null
                      ? Container(
                          height: 40,
                          width: 100,
                          child: Icon(Icons.trip_origin))
                      : Container(
                          width: 130,
                          height: 80,
                          child: _tripLists.image != null
                              ? Image.file(File(_tripLists.image))
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
                      Text(widget.trips.destination,
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
                        child: Text("Start Date :",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      Text(widget.trips.startdate.toString(),
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
                          "End Date :",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(widget.trips.enddate.toString(),
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
                          "Trip Name :",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(widget.trips.tripname,
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
                          "Description :",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(widget.trips.description,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Add Plan",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.purple)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
