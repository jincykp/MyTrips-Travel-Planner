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

class _ViewTripDetailsState extends State<ViewTripDetails>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  late TripModel tripListss;
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

    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeOutBack));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildInfoRow(String label, String value,
      {bool isDescription = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 110,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: Text(
                value,
                style: TextStyle(
                  color: isDescription ? Colors.white70 : Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: isDescription ? 3 : 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF667eea),
            Color(0xFF764ba2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.schedule, color: Colors.white, size: 24),
              SizedBox(width: 10),
              Text(
                "Trip Plans",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _buildInfoRow("Activity:", tripListss.actvityType ?? 'Not specified'),
          _buildInfoRow("Title:", tripListss.title ?? 'Not specified'),
          _buildInfoRow("Time:", tripListss.time ?? 'Not specified'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1a1a2e),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF16213e),
        foregroundColor: Colors.white,
        title: Text(
          "Trip Details",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF16213e), Color(0xFF0f3460)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF16213e),
                              Color(0xFF0f3460),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image Section
                              Container(
                                width: double.infinity,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 10,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: tripListss.image == null
                                      ? Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.blue.withOpacity(0.3),
                                                Colors.purple.withOpacity(0.3),
                                              ],
                                            ),
                                          ),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.landscape,
                                                  size: 50,
                                                  color: Colors.white70,
                                                ),
                                                SizedBox(height: 8),
                                                Text(
                                                  "No Image",
                                                  style: TextStyle(
                                                    color: Colors.white70,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Image.file(
                                          File(tripListss.image!),
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              SizedBox(height: 24),

                              // Trip Details Section
                              _buildInfoRow(
                                  "Destination:", tripListss.destination ?? ''),
                              _buildInfoRow(
                                "Start Date:",
                                DateFormat('dd MMM yyyy')
                                    .format(tripListss.startdate!),
                              ),
                              _buildInfoRow(
                                "End Date:",
                                DateFormat('dd MMM yyyy')
                                    .format(tripListss.enddate!),
                              ),
                              _buildInfoRow(
                                  "Trip Name:", tripListss.tripname ?? ''),
                              _buildInfoRow(
                                "Description:",
                                tripListss.description ?? '',
                                isDescription: true,
                              ),

                              SizedBox(height: 20),

                              // Add Plan Button or Plan Details
                              if (tripListss.actvityType == null)
                                Center(
                                  child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        TripModel? addedPlan =
                                            await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => addPlanScreen(
                                              planss: tripListss,
                                              id: tripListss.id,
                                            ),
                                          ),
                                        );
                                        if (addedPlan != null) {
                                          setState(() {
                                            showPlanSection = true;
                                            tripListss.actvityType =
                                                addedPlan.actvityType;
                                            tripListss.title = addedPlan.title;
                                            tripListss.time = addedPlan.time;
                                          });
                                          print('Added plan=$addedPlan');
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF667eea),
                                        foregroundColor: Colors.white,
                                        elevation: 8,
                                        shadowColor:
                                            Color(0xFF667eea).withOpacity(0.4),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.add_task, size: 20),
                                          SizedBox(width: 8),
                                          Text(
                                            "Add Plan",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                              if (tripListss.actvityType != null)
                                _buildPlanCard(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
