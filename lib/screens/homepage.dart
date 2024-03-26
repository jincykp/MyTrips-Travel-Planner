import 'package:flutter/material.dart';
import 'package:my_trips/SCREENS/memories.dart';

import 'package:my_trips/profile.dart';
import 'package:my_trips/screens/addtrips.dart';
import 'package:my_trips/screens/mytrips.dart';
import 'package:my_trips/screens/pasttrips.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  List<Widget> _screens = [
    TripScreen(),
    //SearchScreen(),
    PastTripScreen(),
    MemoryScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          body: _screens[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (i) {
              setState(() {
                _selectedIndex = i;
              });
            },
            currentIndex: _selectedIndex,
            backgroundColor: Color.fromARGB(255, 1, 1, 19),
            selectedItemColor: Colors.white,
            unselectedItemColor: Color.fromARGB(255, 73, 70, 70),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.wallet_travel), label: "Trips"),
              // BottomNavigationBarItem(
              //     icon: Icon(Icons.search), label: "Search"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.card_travel), label: "Past Trips"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.image), label: "Memories"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
            ],
          ),
          floatingActionButton: _selectedIndex == 0
              ? FloatingActionButton(
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
                )
              : null),
    );
  }
}
