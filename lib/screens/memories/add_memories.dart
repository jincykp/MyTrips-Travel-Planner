import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_trips/database/functions/memories_db_functions.dart';
import 'package:my_trips/database/model/memories_model.dart';
import 'package:my_trips/screens/loginscreens/support.dart';
import 'package:image_picker/image_picker.dart';

class AddMemoriesScreen extends StatefulWidget {
  AddMemoriesScreen({super.key});

  @override
  State<AddMemoriesScreen> createState() => _AddMemoriesScreenState();
}

class _AddMemoriesScreenState extends State<AddMemoriesScreen> {
  final _formKey = GlobalKey<FormState>();
  final memoryNameController = TextEditingController();
  final memoryDateController = TextEditingController();
  final memoryExperienceController = TextEditingController();
  String? MemoryPhotos;
  bool selecetedimg = false;
  DateTime? MemoryDate;
  List<String> imagePath = [];
  // XFile? selectedImage;
  // bool hasSelectedImage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 6, 6, 37),
      appBar: AppBar(
        title: Text("ADD YOUR MEMORY"),
        backgroundColor: Color.fromARGB(255, 7, 7, 19),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      IconButton.filled(
                        onPressed: () {
                          addMemoryImage(context);
                        },
                        icon: Icon(
                          Icons.add_a_photo,
                          size: 50,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Trip Name",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                TripFormFields(
                    controller: memoryNameController,
                    hintText: "Enter memory name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Trip name is required";
                      }
                      return null;
                    }),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Trip Date",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                TripFormFields(
                  controller: memoryDateController,
                  hintText: "Enter Trip Date",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Trip name is required";
                    }
                    return null;
                  },
                  prefixIcon: IconButton(
                      onPressed: () async {
                        MemoryDate = await pickDate(true);
                      },
                      icon: Icon(
                        Icons.calendar_month,
                        color: Colors.white,
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Experience",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TripFormFields(
                    controller: memoryExperienceController,
                    hintText: "Enter your experience",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "experience is required";
                      }
                      return null;
                    }),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.purple)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print("'memory valid");
                        saveMemories();
                      }
                    },
                    child: Text(
                      "SAVE",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  saveMemories() async {
    print(" save memory function called ");
    final memoryyname = memoryNameController.text.trim();
    final memoryydate = memoryDateController.text.trim();
    final memoryyexperience = memoryExperienceController.text.trim();
    final memories = MemoryModel(
        MemoryImage: imagePath,
        MemoryTripName: memoryyname,
        MemoryDate: memoryydate,
        MemoryExperience: memoryyexperience);
    await addMemories(memories);
    // print("memory added");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Memories  added successfully"),
      backgroundColor: const Color.fromARGB(255, 22, 73, 114),
    ));
    Navigator.of(context).pop(memories);
  }

  Future<void> addMemoryImage(BuildContext context) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickMultiImage();
    if (pickedImage != null) {
      setState(() {
        imagePath.clear();
        for (final multiImg in pickedImage) {
          if (multiImg != null) {
            imagePath.add(File(multiImg.path).path);
          }
        }
        selecetedimg = imagePath.isNotEmpty;
      });
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
          memoryDateController.text = _picked.toString().split(" ")[0];
        }
      });
      return _picked;
    }
    return null;
  }
}
