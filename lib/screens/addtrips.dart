import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_trips/database/functions/trip_db_functions.dart';
import 'package:my_trips/database/model/trip_model.dart';
import 'package:my_trips/screens/loginscreens/support.dart';

class AddTripScreen extends StatefulWidget {
  const AddTripScreen({super.key});

  @override
  State<AddTripScreen> createState() => _AddTripScreenState();
}

class _AddTripScreenState extends State<AddTripScreen> {
  final TextStyle textStyle =
      TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
  final _formKey = GlobalKey<FormState>();
  late DateTime? startingDate;
  late DateTime? endingDate;
  final _destinationController = TextEditingController();
  final _startdateController = TextEditingController();
  final _enddateController = TextEditingController();
  final _tripnameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? images;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 6, 6, 37),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 7, 7, 19),
        foregroundColor: Colors.white,
        title: Text(
          "ADD TRIPS",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                images == null
                    ? Container(
                        width: 140,
                        height: 60,
                        color: Colors.white,
                        child: Positioned(
                          bottom: 4,
                          right: 0,
                          child: IconButton(
                            onPressed: () {
                              addtripImage();
                            },
                            icon: Icon(Icons.add_a_photo_outlined),
                            iconSize: 55,
                          ),
                        ))
                    : Container(
                        width: 100,
                        height: 70,
                        child: Image.file(
                          File(images!),
                          fit: BoxFit.cover,
                        ),
                      ),
                SizedBox(
                  height: 10,
                ),
                // TextButton(
                //     onPressed: () {
                //       addtripImage();
                //     },
                //     child: Text("Add image")),
                Row(
                  children: [
                    Text(
                      "Destination:",
                      style: textStyle,
                    ),
                  ],
                ),
                TripFormFields(
                  controller: _destinationController,
                  hintText: "Enter the destination",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Destination is required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "Start Date:",
                      style: textStyle,
                    ),
                  ],
                ),
                TripFormFields(
                    controller: _startdateController,
                    hintText: "Enter the start date",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Start date is required';
                      }

                      return null;
                    },
                    prefixIcon: IconButton(
                      onPressed: () async {
                        startingDate = await pickDate(true);
                      },
                      icon: Icon(
                        Icons.calendar_month,
                        color: const Color.fromARGB(255, 185, 178, 178),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text("End Date:", style: textStyle),
                  ],
                ),
                TripFormFields(
                  controller: _enddateController,
                  hintText: "Enter the end date",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'End date  is required';
                    }

                    return null;
                  },
                  prefixIcon: IconButton(
                      onPressed: () async {
                        endingDate = await pickDate(false);
                      },
                      icon: Icon(
                        Icons.calendar_month,
                        color: const Color.fromARGB(255, 185, 178, 178),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text("Trip Name:", style: textStyle),
                  ],
                ),
                TripFormFields(
                  controller: _tripnameController,
                  hintText: "Enter the trip name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Trip name is required';
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text("Description:", style: textStyle),
                  ],
                ),
                TripFormFields(
                  controller: _descriptionController,
                  hintText: "Enter the description",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description is required';
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print("form is valid");
                          saveTrip();
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.purple),
                      ),
                      child: Text("SAVE", style: textStyle),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  saveTrip() async {
    //  final String tripimage = images;
    print('function called');
    final tripDestination = _destinationController.text.trim();
    final tripstartDate = DateTime.parse(_startdateController.text.trim());
    final tripendDate = DateTime.parse(_enddateController.text.trim());
    final tripName = _tripnameController.text.trim();
    final tripDescription = _descriptionController.text.trim();
    // final tripimage = images;
    if (_destinationController.text.isNotEmpty ||
        _startdateController.text.isNotEmpty ||
        _enddateController.text.isNotEmpty ||
        _tripnameController.text.isNotEmpty ||
        _descriptionController.text.isNotEmpty) {
      final trips = TripModel(
          destination: tripDestination,
          startdate: tripstartDate,
          enddate: tripendDate,
          tripname: tripName,
          description: tripDescription,
          image: images.toString());

      await AddTrips(trips);

      print("trip added");
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Trip added successfully"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ));
    }
  }

  Future<DateTime?> pickDate(bool startDate) async {
    DateTime? _picked = await showDatePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime(2050),
        initialDate: DateTime.now());
    if (_picked != null) {
      setState(() {
        if (startDate) {
          _startdateController.text = _picked.toString().split(" ")[0];
        } else {
          _enddateController.text = _picked.toString().split(" ")[0];
        }
      });
      return _picked;
    }
  }

  addtripImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        images = pickedImage.path;
      });
    }
  }
}
