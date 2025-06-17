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
        // Filter to show only upcoming trips
        tripsList = getUpcomingTrips(tripListNotifier.value.toList());
      });
    });
  }

  // Function to filter upcoming trips
  List<TripModel> getUpcomingTrips(List<TripModel> allTrips) {
    DateTime today = DateTime.now();
    DateTime todayOnly = DateTime(today.year, today.month, today.day);

    return allTrips.where((trip) {
      if (trip.startdate == null) return false;

      DateTime tripStartDate = DateTime(
        trip.startdate!.year,
        trip.startdate!.month,
        trip.startdate!.day,
      );

      // Include trips that start today or in the future
      return tripStartDate.isAtSameMomentAs(todayOnly) ||
          tripStartDate.isAfter(todayOnly);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A1A2E),
              Color(0xFF16213E),
              Color(0xFF0F3460),
            ],
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "UPCOMING TRIPS",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 16),
          buildSearchTextField(),
        ],
      ),
      toolbarHeight: 140,
    );
  }

  Widget buildSearchTextField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        style: TextStyle(color: Color.fromARGB(255, 6, 6, 37)),
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            searchTrips(value);
            reg = _searchController.text;
          });
        },
        decoration: InputDecoration(
          hintText: 'Search upcoming destinations...',
          hintStyle: TextStyle(color: Colors.grey[500]),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          prefixIcon: Icon(Icons.search, color: Color.fromARGB(255, 6, 6, 37)),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    _searchController.clear();
                    searchTrips('');
                    setState(() {});
                  },
                )
              : null,
          border: InputBorder.none,
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView.builder(
        itemBuilder: (context, index) {
          var trip = tripsList[index];
          return buildTripCard(trip, index);
        },
        itemCount: tripsList.length,
      ),
    );
  }

  Widget buildTripCard(TripModel trip, int index) {
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
                  builder: (context) => ViewTripDetails(
                    trips: trip,
                    planList: planList,
                  ),
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
                          Icons.travel_explore,
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
              child: Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.white70, size: 16),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "${trip.startdate?.toString().split(' ')[0]} - ${trip.enddate?.toString().split(' ')[0]}",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            trailing: buildTripTrailing(trip),
          ),
        ),
      ),
    );
  }

  Widget buildNoTripWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 6, 6, 37).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.travel_explore,
              size: 50,
              color: Color.fromARGB(255, 6, 6, 37).withOpacity(0.5),
            ),
          ),
          SizedBox(height: 24),
          Text(
            "No Upcoming Trips",
            style: TextStyle(
              color: Color.fromARGB(255, 6, 6, 37),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Text(
            "Start planning your next adventure!",
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTripTrailing(TripModel trip) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
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
            icon: Icon(Icons.edit, color: Colors.white, size: 20),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            onPressed: () {
              deleteAlertDialog(context, trip.id!);
            },
            icon: Icon(Icons.delete, color: Colors.red[300], size: 20),
          ),
        ),
      ],
    );
  }

  Widget buildFloatingActionButton() {
    return Container(
      margin: EdgeInsets.all(16),
      child: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTripScreen()),
          );
        },
        icon: Icon(Icons.add, color: Colors.white),
        label: Text(
          "Add Trip",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 1, 1, 19),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  void deleteAlertDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red),
              SizedBox(width: 12),
              Text(
                "Delete Trip",
                style: TextStyle(
                  color: Color.fromARGB(255, 6, 6, 37),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            "Are you sure you want to delete this trip? This action cannot be undone.",
            style: TextStyle(color: Colors.grey[700]),
          ),
          actions: [
            TextButton(
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.grey[600]),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("Delete", style: TextStyle(color: Colors.white)),
              onPressed: () {
                deleteTrip(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void searchTrips(String data) {
    List<TripModel> searchResults = [];
    // Get upcoming trips first
    List<TripModel> upcomingTrips = getUpcomingTrips(tripListNotifier.value);

    if (data.isEmpty) {
      searchResults = upcomingTrips;
    } else {
      searchResults = upcomingTrips
          .where((user) =>
              user.destination!.toLowerCase().contains(data.toLowerCase()))
          .toList();
    }
    setState(() {
      tripsList = searchResults;
    });
  }
}
