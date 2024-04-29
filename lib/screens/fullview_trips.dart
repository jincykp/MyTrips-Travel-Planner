import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_trips/database/functions/trip_db_functions.dart';
import 'package:my_trips/database/model/trip_model.dart';
import 'package:intl/intl.dart';
import 'package:my_trips/screens/plans/addplan.dart';

class ViewTripDetails extends StatefulWidget {
  final TripModel trips;
  final List<TripModel>? planList;

  ViewTripDetails({super.key, required this.trips, required this.planList});

  @override
  State<ViewTripDetails> createState() => _ViewTripDetailsState();
}

class _ViewTripDetailsState extends State<ViewTripDetails> {
  final TextStyle _whiteTextStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  final TextStyle _descriptionTextStyle = TextStyle(
      color: const Color.fromARGB(255, 233, 224, 224),
      fontWeight: FontWeight.bold);

  var tripListss;
  bool showPlanSection = false;
  List<TripModel> planListsss = [];

  @override
  void initState() {
    super.initState();
    tripListss = widget.trips;
    planListsss = widget.planList ?? [];
    if (planListsss.isNotEmpty) {
      showPlanSection = true;
    }
    updateTrip();
  }

  Widget buildPlanDetails(TripModel plan) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(
                width: 130,
                child: Text(
                  "Activity Type:",
                  style: _whiteTextStyle,
                ),
              ),
              Text(
                plan.actvityType ?? '',
                style: _whiteTextStyle,
              )
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 130,
                child: Text(
                  "Title:",
                  style: _whiteTextStyle,
                ),
              ),
              Text(
                plan.title ?? '',
                style: _whiteTextStyle,
              )
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 130,
                child: Text(
                  "Time:",
                  style: _whiteTextStyle,
                ),
              ),
              Text(
                plan.time ?? '',
                style: _whiteTextStyle,
              )
            ],
          ),
          SizedBox(height: 10),
          Divider(color: Colors.white),
        ],
      ),
    );
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Color.fromARGB(255, 6, 6, 37),
              elevation: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                width: 400,
                height: 700,
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
                                height: 200,
                                child: tripListss.image != null
                                    ? Image.file(File(tripListss.image))
                                    : Container()),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            SizedBox(
                              width: 130,
                              child: Text(
                                "Destination :",
                                style: _whiteTextStyle,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                tripListss.destination,
                                style: _whiteTextStyle,
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
                                "Start Date :",
                                style: _whiteTextStyle,
                              ),
                            ),
                            Text(
                              DateFormat('dd-MM-yyyy')
                                  .format(tripListss.startdate),
                              style: _whiteTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            SizedBox(
                              width: 130,
                              child: Text(
                                "End Date :",
                                style: _whiteTextStyle,
                              ),
                            ),
                            Text(
                              DateFormat('dd-MM-yyyy')
                                  .format(tripListss.enddate),
                              style: _whiteTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            SizedBox(
                              width: 130,
                              child: Text(
                                "Trip Name:",
                                style: _whiteTextStyle,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                tripListss.tripname,
                                style: _whiteTextStyle,
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
                                style: _whiteTextStyle,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                tripListss.description,
                                style: _descriptionTextStyle,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Visibility(
                          visible: planListsss.isEmpty,
                          child: ElevatedButton(
                            onPressed: () async {
                              TripModel? addedPlan = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => addPlanScreen(
                                          planss: tripListss,
                                          id: tripListss.id)));
                              if (addedPlan != null) {
                                setState(() {
                                  showPlanSection = true;
                                  tripListss = addedPlan.actvityType;
                                  tripListss = addedPlan.title;
                                  tripListss = addedPlan.time;
                                });
                                print('Added plan=$addedPlan');
                              }
                            },
                            child: Text(
                              "Add Plan",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.purple),
                            ),
                          ),
                        ),
                        Visibility(
                          child: Column(
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
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Activity type: ${widget.trips.actvityType}',
                                style: _whiteTextStyle,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text('Activity type: ${widget.trips.title}',
                                  style: _whiteTextStyle),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Activity type: ${widget.trips.time}',
                                style: _whiteTextStyle,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
