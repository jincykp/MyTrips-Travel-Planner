import 'package:flutter/material.dart';
import 'package:my_trips/screens/memories/memories.dart';
import 'package:my_trips/screens/mytrips.dart';
import 'package:my_trips/screens/pasttrips.dart';
import 'package:my_trips/screens/settings_screens/profile.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  List<Widget> _screens = [
    TripScreen(),
    PastTripScreen(),
    MemoryScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BottomNavigationBar(
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
              selectedFontSize: 12,
              unselectedFontSize: 10,
              iconSize: 24,
              selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              items: [
                BottomNavigationBarItem(
                  icon: Container(
                    padding: EdgeInsets.all(8),
                    decoration: _selectedIndex == 0
                        ? BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          )
                        : null,
                    child: Icon(Icons.wallet_travel_outlined),
                  ),
                  activeIcon: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 6, 6, 37),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.3),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(Icons.wallet_travel, color: Colors.white),
                  ),
                  label: "Trips",
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    padding: EdgeInsets.all(8),
                    decoration: _selectedIndex == 1
                        ? BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          )
                        : null,
                    child: Icon(Icons.history_outlined),
                  ),
                  activeIcon: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 6, 6, 37),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.3),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(Icons.history, color: Colors.white),
                  ),
                  label: "Past Trips",
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    padding: EdgeInsets.all(8),
                    decoration: _selectedIndex == 2
                        ? BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          )
                        : null,
                    child: Icon(Icons.photo_library_outlined),
                  ),
                  activeIcon: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 6, 6, 37),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.3),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(Icons.photo_library, color: Colors.white),
                  ),
                  label: "Memories",
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    padding: EdgeInsets.all(8),
                    decoration: _selectedIndex == 3
                        ? BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          )
                        : null,
                    child: Icon(Icons.person_outline),
                  ),
                  activeIcon: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 6, 6, 37),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.3),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  label: "Profile",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
