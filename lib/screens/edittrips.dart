import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:my_trips/database/functions/trip_db_functions.dart';
import 'package:my_trips/database/model/trip_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_trips/screens/loginscreens/support.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({required this.tripss, required this.id, super.key});
  final TripModel tripss;
  final int id;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final TextStyle textStyle =
      TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
  DateTime? startingDate;
  DateTime? endingDate;
  final _destinationController = TextEditingController();
  final _startdateController = TextEditingController();
  final _enddateController = TextEditingController();
  final _tripnameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? imagee;

  @override
  void initState() {
    // TODO: implement initState
    startingDate = widget.tripss.startdate;
    _startdateController.text =
        DateFormat('dd-MM-yyyy').format(widget.tripss.startdate!);
    endingDate = widget.tripss.enddate;
    _enddateController.text =
        DateFormat('dd-MM-yyyy').format(widget.tripss.enddate!);
    // DateTime? startDate = DateTime.parse(_startdateController.text.trim());
    // DateTime? endDate = DateTime.parse(_enddateController.text.trim());
    _destinationController.text = widget.tripss.destination!;
    // _startdateController.text = startDate.toString();
    // _enddateController.text = endDate.toString();
    _tripnameController.text = widget.tripss.tripname!;
    _descriptionController.text = widget.tripss.description!;
    imagee = widget.tripss.image;

    super.initState();
  }

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
                imagee == null
                    ? Container(
                        width: 100,
                        height: 80,
                        color: Colors.white,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.add_a_photo_outlined),
                          iconSize: 55,
                        ))
                    : Container(
                        height: 80,
                        width: 100,
                        child: Image.file(
                          File(imagee!),
                          fit: BoxFit.cover,
                        ),
                      ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      addtripImage();
                    },
                    child: Text("change image")),
                SizedBox(
                  height: 15,
                ),
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
                      return 'Change the destination';
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
                        return 'Change the start date';
                      }

                      return null;
                    },
                    prefixIcon: IconButton(
                        onPressed: () async {
                          startingDate = await pickDate(true);
                        },
                        icon: Icon(Icons.calendar_month))),
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
                      return 'Change the end date';
                    }

                    return null;
                  },
                  prefixIcon: IconButton(
                      onPressed: () async {
                        endingDate = await pickDate(false);
                      },
                      icon: Icon(Icons.calendar_month)),
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
                      return 'Change the tripname';
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
                      return 'Change the description';
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
                          final tripdatas = TripModel(
                              id: widget.tripss.id,
                              destination: _destinationController.text.trim(),
                              startdate: startingDate,
                              enddate: endingDate,
                              tripname: _tripnameController.text.trim(),
                              description: _descriptionController.text.trim(),
                              image: imagee.toString());
                          editTrip(tripdatas);
                          Navigator.of(context).pop();
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.purple),
                      ),
                      child: Text("UPDATE", style: textStyle),
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

  Future<DateTime?>? pickDate(bool startDate) async {
    DateTime? _picked = await showDatePicker(
        context: context, firstDate: DateTime(2000), lastDate: DateTime(2050));
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
        imagee = pickedImage.path;
      });
    }
  }
}
