import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_trips/database/model/trip_model.dart';
import 'package:intl/intl.dart';
import 'package:my_trips/screens/plans/addplan.dart';
import 'package:my_trips/screens/plans/plans.dart';

class ViewTripDetails extends StatefulWidget {
  final TripModel trips;

  ViewTripDetails({super.key, required this.trips});

  @override
  State<ViewTripDetails> createState() => _ViewTripDetailsState();
}

class _ViewTripDetailsState extends State<ViewTripDetails> {
  var tripListss;
  bool showPlanSection = false;
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
          color: Color.fromARGB(255, 6, 6, 37),
          elevation: 50,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: 350,
            height: 800,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(tripListss.destination,
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
                        Text(
                            DateFormat('dd-MM-yyyy')
                                .format(tripListss.startdate),
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                            DateFormat('dd-MM-yyyy').format(tripListss.enddate),
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(tripListss.tripname,
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
                            "Description:",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(tripListss.description,
                            style: TextStyle(
                                color: const Color.fromARGB(255, 233, 224, 224),
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showPlanSection = true;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => addPlanScreen(
                                    planss: tripListss,
                                    id: tripListss.id))).then((value) => null);
                      },
                      child: Text(
                        "Add Plan",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.purple)),
                    ),
                    if (showPlanSection) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(
                              "Plans",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 130,
                            child: Text(
                              "Activity Type:",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Text(
                            "",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 130,
                            child: Text(
                              "Title:",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Text(
                            "",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 130,
                            child: Text(
                              "Time:",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Text(
                            "",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
