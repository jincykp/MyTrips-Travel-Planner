// ignore_for_file: unused_import, unnecessary_import
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_trips/database/functions/trip_db_functions.dart';
import 'package:my_trips/database/model/trip_model.dart';
import 'package:my_trips/screens/fullview.dart';
import 'package:my_trips/screens/loginscreens/support.dart';
import 'package:intl/intl.dart';

class addPlanScreen extends StatefulWidget {
  const addPlanScreen({required this.planss, required this.id, super.key});
  final TripModel planss;
  final id;

  @override
  State<addPlanScreen> createState() => _addPlanScreenState();
}

class _addPlanScreenState extends State<addPlanScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedTime;
  final activitytypeController = TextEditingController();
  final titleController = TextEditingController();
  final timeController = TextEditingController();
  String? valueChoose;
  TimeOfDay? _time;
  List<String> listitems = [
    "Notes",
    "Meeting",
    "Activity",
    "Call",
    "Functions"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 7, 7, 19),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 6, 6, 37),
        foregroundColor: Colors.white,
        title: Text("ADD YOUR PLANS"),
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                print("valid");
                saveActivity();
                // Navigator.of(context).pop();
              }
            },
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            iconSize: 27,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Activity Type:",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                TextFormField(
                  controller: activitytypeController,
                  decoration: InputDecoration(
                    hintText: "Select your Activity",
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 136, 125, 125)),
                    suffixIcon: PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      onSelected: (String? value) {
                        setState(() {
                          valueChoose = value;
                          activitytypeController.text = value ?? '';
                        });
                      },
                      itemBuilder: (BuildContext context) {
                        return listitems
                            .map<PopupMenuEntry<String>>((String item) {
                          return PopupMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList();
                      },
                    ),
                  ),
                  readOnly: true, // Makes the text field non-editable
                  onTap: () {
                    FocusScope.of(context)
                        .requestFocus(new FocusNode()); // Dismiss the keyboard
                  },
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Activity Type is required';
                    }
                    return null;
                  },
                ),
                // TripFormFields(
                //   controller: activitytypeController,
                //   hintText: "Select your Activity",
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return "Activity Type is required";
                //     }
                //     return null;
                //   },
                //   prefixIcon: Padding(
                //     padding: const EdgeInsets.all(15.0),
                //     child: DropdownButton(
                //       dropdownColor: const Color.fromARGB(255, 93, 35, 104),
                //       hint: Text(
                //         "Select activity type:",
                //         style: TextStyle(
                //             color: const Color.fromARGB(255, 134, 133, 133)),
                //       ),
                //       icon: Icon(Icons.arrow_drop_down),
                //       iconSize: 30,
                //       isExpanded: true,
                //       value: valueChoose,
                //       onChanged: (newValue) {
                //         setState(() {
                //           valueChoose = newValue;
                //           activitytypeController.text = newValue ?? '';
                //         });
                //       },
                //       items: listitems.map((valueItem) {
                //         return DropdownMenuItem(
                //           value: valueItem,
                //           child: Text(
                //             valueItem,
                //             style: TextStyle(color: Colors.white),
                //           ),
                //         );
                //       }).toList(),
                //     ),
                //   ),
                // ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Title:",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                TripFormFields(
                    controller: titleController,
                    hintText: "Enter a title",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Title  is required";
                      }
                      return null;
                    }),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Time:",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                TripFormFields(
                  controller: timeController,
                  hintText: "Select time",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Time is required";
                    }
                    return null;
                  },
                  prefixIcon: IconButton(
                      onPressed: () async {
                        _time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay(hour: 00, minute: 00));
                        setState(() {
                          timeController.text = _time!.format(context);
                        });
                      },
                      icon: Icon(Icons.timer_outlined)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  saveActivity() async {
    print(" save activity function called ");
    final activitytypeee = activitytypeController.text.trim();
    final titletitle = titleController.text.trim();
    // final timetime = DateTime.parse(timeController.text.trim());
    // TimeOfDay selectedTime =
    //     TimeOfDay.fromDateTime(DateTime.parse(timeController.text.trim()));
    String timetime = _time!.format(context);
    TripModel addplantrip = TripModel(
        id: widget.planss.id,
        destination: widget.planss.destination,
        startdate: widget.planss.startdate,
        enddate: widget.planss.enddate,
        tripname: widget.planss.tripname,
        description: widget.planss.description,
        image: widget.planss.image,
        actvityType: activitytypeee,
        title: titletitle,
        time: timetime);
    await addPlans(addplantrip);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Plans added successfully"),
        backgroundColor: Color.fromARGB(255, 26, 62, 92),
      ),
    );
    Navigator.of(context).pop(addplantrip);
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => ViewTripDetails(trips: addplantrip)));
  }
}
