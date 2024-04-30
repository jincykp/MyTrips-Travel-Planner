import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_trips/database/functions/memories_db_functions.dart';
import 'package:my_trips/database/model/memories_model.dart';
import 'package:my_trips/screens/loginscreens/support.dart';
import 'package:my_trips/screens/memories/memory_fullview.dart';

class EditMemory extends StatefulWidget {
  MemoryModel mEdit;
  final int id;
  EditMemory({required this.mEdit, required this.id, super.key});

  @override
  State<EditMemory> createState() => _EditMemoryState();
}

class _EditMemoryState extends State<EditMemory> {
  final _formKey = GlobalKey<FormState>();
  final memoryNameController = TextEditingController();
  final memoryDateController = TextEditingController();
  final memoryExperienceController = TextEditingController();
  String? MemoryPhotos;
  bool selecetedimg = false;
  DateTime? MemoryDate;
  List<String> imagePath = [];
  XFile? selectedImage;
  bool hasSelectedImage = false;
  List<String>? mImagesss;
  @override
  void initState() {
    memoryNameController.text = widget.mEdit.MemoryTripName!;
    memoryDateController.text = widget.mEdit.MemoryDate!;
    memoryExperienceController.text = widget.mEdit.MemoryExperience!;
    imagePath = List<String>.from(widget.mEdit.MemoryImage ?? []);
    // TODO: implement initState
    super.initState();
  }

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
                      ...List.generate(
                          imagePath.length,
                          (index) => CircleAvatar(
                                radius: 50,
                                backgroundImage: imagePath.isNotEmpty
                                    ? FileImage(File(imagePath[index]))
                                    : const AssetImage("") as ImageProvider,
                              )),
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
                        final memoDatas = MemoryModel(
                            id: widget.mEdit.id,
                            MemoryImage: imagePath,
                            MemoryTripName: memoryNameController.text,
                            MemoryDate: memoryDateController.text,
                            MemoryExperience: memoryExperienceController.text);
                        // saveMemories();
                        editMemories(memoDatas).then((value) {
                          Navigator.of(context).pop();
                          // Navigator.of(context).pop();
                        });
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
