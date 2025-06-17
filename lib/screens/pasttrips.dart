import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_trips/database/functions/trip_db_functions.dart';
import 'package:my_trips/database/model/trip_model.dart';
import 'package:my_trips/screens/fullviewof_past.dart';

class PastTripScreen extends StatefulWidget {
  const PastTripScreen({Key? key}) : super(key: key);

  @override
  State<PastTripScreen> createState() => _PastTripScreenState();
}

class _PastTripScreenState extends State<PastTripScreen> {
  late List<TripModel> tripslist;

  @override
  void initState() {
    tripslist = tripListNotifier.value
        .where((trip) => trip.enddate!.isBefore(DateTime.now()))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 6, 6, 37),
                Color.fromARGB(255, 6, 6, 37),
                Color.fromARGB(255, 1, 1, 19),
              ],
            ),
          ),
        ),
        title: Text(
          "PAST TRIPS",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: ValueListenableBuilder<List<TripModel>>(
        valueListenable: tripListNotifier,
        builder: (context, tripList, _) {
          if (tripslist.isNotEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  var trip = tripslist[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 16),
                    child: Card(
                      elevation: 8,
                      shadowColor: Colors.black.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(255, 109, 109, 143),
                              Color.fromARGB(255, 109, 109, 143),
                            ],
                          ),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PastFullView(trips: trip),
                              ),
                            );
                          },
                          leading: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: trip.image == '' || trip.image == null
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Icon(
                                        Icons.photo_album,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    )
                                  : Image.file(
                                      File(trip.image!),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          title: Text(
                            "${trip.destination}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Container(
                            margin: EdgeInsets.only(top: 8),
                            child: Text(
                              "${trip.tripname}",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white70,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: tripslist.length,
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Color(0xFF8B5CF6).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.history,
                      size: 50,
                      color: Color(0xFF8B5CF6).withOpacity(0.5),
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "No Past Trips",
                    style: TextStyle(
                      color: Color.fromARGB(255, 6, 6, 37),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Your completed trips will appear here",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
