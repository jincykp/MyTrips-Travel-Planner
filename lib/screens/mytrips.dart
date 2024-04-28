// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:my_trips/database/functions/trip_db_functions.dart';
// import 'package:my_trips/database/model/trip_model.dart';
// import 'package:my_trips/screens/addtrips.dart';
// import 'package:my_trips/screens/edittrips.dart';
// import 'package:my_trips/screens/fullview_trips.dart';

// class TripScreen extends StatefulWidget {
//   const TripScreen({super.key});

//   @override
//   State<TripScreen> createState() => _TripScreenState();
// }

// class _TripScreenState extends State<TripScreen> {
//   //late TripModel triplist;
//   late List<TripModel> tripslist = [];
//   late List<TripModel> planList = [];
//   String reg = '';
//   final TextEditingController _searchcontroller = TextEditingController();

//   @override
//   void initState() {
//     updateTrip();
//     // TODO: implement initState
//     super.initState();

//     tripListNotifier.addListener(() {
//       tripslist = tripListNotifier.value.toList();
//     });
//   }

//   void sortTrips() {
//     tripslist.sort((a, b) => a.startdate!.compareTo(b.startdate!));
//   }

//   void searchTrips(String datas) {
//     List<TripModel> searchResults = [];
//     if (datas.isEmpty) {
//       searchResults = tripListNotifier.value;
//     } else {
//       searchResults = tripListNotifier.value
//           .where((user) =>
//               user.destination!.toLowerCase().contains(datas.toLowerCase()))
//           .toList();
//     }
//     setState(() {
//       tripslist = searchResults;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           foregroundColor: Colors.white,
//           title: Column(
//             children: [
//               Text(
//                 "MY TRIPS",
//               ),
//               SizedBox(height: 18),
//               TextField(
//                 style: TextStyle(color: Colors.white),
//                 controller: _searchcontroller,
//                 onChanged: (value) {
//                   setState(() {
//                     searchTrips(value);
//                     reg = _searchcontroller.text;
//                   });
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'Search...',
//                   hintStyle: TextStyle(color: Colors.grey),
//                   contentPadding:
//                       const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
//                   prefixIcon: const Icon(Icons.search),
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20)),
//                 ),
//               )
//             ],
//           ),
//           backgroundColor: Color.fromARGB(255, 6, 6, 37),
//           toolbarHeight: 140),
//       body: Column(
//         children: [
//           Expanded(
//             child: ValueListenableBuilder<List<TripModel>>(
//               valueListenable: tripListNotifier,
//               builder: (context, tripList, _) {
//                 if (tripslist.isNotEmpty) {
//                   return ListView.builder(
//                     itemBuilder: (context, index) {
//                       var trip = tripslist[index];
//                       return Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           height: 100,
//                           child: Card(
//                             color: Color.fromARGB(255, 109, 109, 143),
//                             child: ListTile(
//                               contentPadding: EdgeInsets.symmetric(
//                                   vertical: 6, horizontal: 10),
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => ViewTripDetails(
//                                               trips: trip,
//                                               planList: planList,
//                                             )));
//                               },
//                               leading: trip.image == ''
//                                   ? Container(
//                                       width: 100,
//                                       height: 130,
//                                       //color: Colors.white,
//                                       child: Icon(Icons.trip_origin),
//                                     )
//                                   : Container(
//                                       width: 100,
//                                       height: 130,
//                                       child: ClipRRect(
//                                         borderRadius: BorderRadius.circular(8),
//                                         child: Image.file(
//                                           File(trip.image!),
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),
//                               title: Text(
//                                 "${trip.destination}",
//                                 style: TextStyle(color: Colors.white),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               subtitle: Text(
//                                 "${trip.startdate}-${trip.enddate}",
//                                 style: TextStyle(color: Colors.white),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               trailing: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   IconButton(
//                                       onPressed: () {
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     EditScreen(
//                                                       tripss: tripList[index],
//                                                       id: tripList[index].id ??
//                                                           0,
//                                                     )));
//                                       },
//                                       icon: Icon(
//                                         Icons.edit,
//                                         color: Colors.black,
//                                       )),
//                                   IconButton(
//                                     onPressed: () {
//                                       deleteAlertDialog(
//                                           context, tripList[index].id!);
//                                     },
//                                     icon: Icon(
//                                       Icons.delete,
//                                       color: Colors.red,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                     itemCount: tripslist.length,
//                   );
//                 } else {
//                   return Center(
//                     child: Text(
//                       "Plan your Trips",
//                       style: TextStyle(
//                         color: Color.fromARGB(255, 6, 6, 37),
//                         fontWeight: FontWeight.normal,
//                       ),
//                     ),
//                   );
//                 }
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 FloatingActionButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => AddTripScreen()));
//                   },
//                   child: Icon(
//                     Icons.add,
//                     color: Colors.white,
//                   ),
//                   backgroundColor: Color.fromARGB(255, 1, 1, 19),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   deleteAlertDialog(
//     BuildContext context,
//     int id,
//   ) {
//     // set up the buttons
//     Widget cancelButton = TextButton(
//       child: Text("Cancel"),
//       onPressed: () {
//         Navigator.of(context).pop();
//       },
//     );
//     Widget continueButton = TextButton(
//       child: Text("Delete"),
//       onPressed: () {
//         print('object');
//         print(id);
//         deleteTrip(id);
//         // if (trip.id != null) {
//         // } else {
//         //   print("trip id is null ");
//         // }
//         Navigator.of(context).pop();
//       },
//     );
//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       backgroundColor: Colors.white,
//       title: Text("Cancel This Trip"),
//       content: Text("Do you want to cancel this trip?"),
//       actions: [
//         cancelButton,
//         continueButton,
//       ],
//     );
//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_trips/database/functions/trip_db_functions.dart';
import 'package:my_trips/database/model/trip_model.dart';
import 'package:my_trips/screens/addtrips.dart';
import 'package:my_trips/screens/edittrips.dart';
import 'package:my_trips/screens/fullview_trips.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({Key? key}) : super(key: key);

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  late List<TripModel> tripsList = [];
  late List<TripModel> planList = [];
  String reg = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    updateTrip();
    tripListNotifier.addListener(() {
      setState(() {
        tripsList = tripListNotifier.value.toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Column(
        children: [
          Text("MY TRIPS"),
          SizedBox(height: 18),
          buildSearchTextField(),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 6, 6, 37),
      foregroundColor: Colors.white,
      toolbarHeight: 140,
    );
  }

  Widget buildSearchTextField() {
    return TextField(
      style: TextStyle(color: Colors.white),
      controller: _searchController,
      onChanged: (value) {
        setState(() {
          searchTrips(value);
          reg = _searchController.text;
        });
      },
      decoration: InputDecoration(
        hintText: 'Search...',
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        Expanded(
          child: ValueListenableBuilder<List<TripModel>>(
            valueListenable: tripListNotifier,
            builder: (context, tripList, _) {
              return tripsList.isNotEmpty
                  ? buildTripListView()
                  : buildNoTripWidget();
            },
          ),
        ),
        buildFloatingActionButton(),
      ],
    );
  }

  Widget buildTripListView() {
    return ListView.builder(
      itemBuilder: (context, index) {
        var trip = tripsList[index];
        return buildTripCard(trip);
      },
      itemCount: tripsList.length,
    );
  }

  Widget buildTripCard(TripModel trip) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        child: Card(
          color: Color.fromARGB(255, 109, 109, 143),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewTripDetails(
                    trips: trip,
                    planList: planList,
                  ),
                ),
              );
            },
            leading: trip.image == ''
                ? Container(
                    width: 100,
                    height: 130,
                    child: Icon(Icons.trip_origin),
                  )
                : Container(
                    width: 100,
                    height: 130,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(trip.image!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
            title: Text(
              "${trip.destination}",
              style: TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              "${trip.startdate}-${trip.enddate}",
              style: TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
            trailing: buildTripTrailing(trip),
          ),
        ),
      ),
    );
  }

  Widget buildNoTripWidget() {
    return Center(
      child: Text(
        "Plan your Trips",
        style: TextStyle(
          color: Color.fromARGB(255, 6, 6, 37),
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  Widget buildTripTrailing(TripModel trip) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditScreen(
                  tripss: trip,
                  id: trip.id ?? 0,
                ),
              ),
            );
          },
          icon: Icon(
            Icons.edit,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: () {
            deleteAlertDialog(context, trip.id!);
          },
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  Widget buildFloatingActionButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTripScreen()),
              );
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Color.fromARGB(255, 1, 1, 19),
          ),
        ],
      ),
    );
  }

  void deleteAlertDialog(BuildContext context, int id) {
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Delete"),
      onPressed: () {
        deleteTrip(id);
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      title: Text("Cancel This Trip"),
      content: Text("Do you want to cancel this trip?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void searchTrips(String data) {
    List<TripModel> searchResults = [];
    if (data.isEmpty) {
      searchResults = tripListNotifier.value;
    } else {
      searchResults = tripListNotifier.value
          .where((user) =>
              user.destination!.toLowerCase().contains(data.toLowerCase()))
          .toList();
    }
    setState(() {
      tripsList = searchResults;
    });
  }
}
