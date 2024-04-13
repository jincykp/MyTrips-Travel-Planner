import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_trips/database/functions/trip_db_functions.dart';
import 'package:my_trips/database/model/trip_model.dart';
import 'package:my_trips/screens/addtrips.dart';
import 'package:my_trips/screens/edittrips.dart';
import 'package:my_trips/screens/fullview.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({super.key});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  //late TripModel triplist;
  late List<TripModel> tripslist = [];

  String reg = '';
  // get image => null;
  final TextEditingController _searchcontroller = TextEditingController();

  var trip;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    updateTrip();
    tripslist = tripListNotifier.value;
  }

  void searchTrips(String datas) {
    List<TripModel> searchResults = [];
    if (datas.isEmpty) {
      searchResults = tripListNotifier.value;
    } else {
      searchResults = tripListNotifier.value
          .where((user) =>
              user.destination!.toLowerCase().contains(datas.toLowerCase()))
          .toList();
    }
    setState(() {
      tripslist = searchResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.white,
          title: Column(
            children: [
              Text(
                "MY TRIPS",
              ),
              SizedBox(height: 18),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: _searchcontroller,
                onChanged: (value) {
                  setState(() {
                    searchTrips(value);
                    reg = _searchcontroller.text;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding:
                      const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              )
            ],
          ),
          backgroundColor: Color.fromARGB(255, 6, 6, 37),
          toolbarHeight: 140),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<List<TripModel>>(
              valueListenable: tripListNotifier,
              builder: (context, tripList, _) {
                if (tripslist.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      trip = tripslist[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          child: Expanded(
                            child: Card(
                              color: Color.fromARGB(255, 109, 109, 143),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ViewTripDetails(
                                              trips: tripList[index])));
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
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditScreen(
                                                        tripss: tripList[index],
                                                        id: tripList[index]
                                                                .id ??
                                                            0,
                                                      )));
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.black,
                                        )),
                                    IconButton(
                                      onPressed: () {
                                        deleteAlertDialog(
                                            context, tripList[index].id!);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddTripScreen()));
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  backgroundColor: Color.fromARGB(255, 1, 1, 19),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  deleteAlertDialog(
    BuildContext context,
    int id,
  ) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Delete"),
      onPressed: () {
        print('object');
        print(id);
        deleteTrip(id);
        // if (trip.id != null) {
        // } else {
        //   print("trip id is null ");
        // }
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      title: Text("Delete This Trip"),
      content: Text("Do you want to delete this trip?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
