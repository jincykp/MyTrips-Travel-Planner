import 'package:flutter/material.dart';

void successMessage(
    {required BuildContext context, required String successMessage}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        successMessage,
        textAlign: TextAlign.center,
      ),
    ),
  );
}

class TextFormfieldData extends StatelessWidget {
  TextEditingController controller;
  String? hintText;
  String? Function(String?)? validator;

  TextFormfieldData(
      {super.key,
      required this.controller,
      this.validator,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText),
      validator: validator,
    );
  }
}

//tripfield--
class TripFormFields extends StatelessWidget {
  TextEditingController controller;
  String? hintText;
  String? Function(String?)? validator;
  Widget? prefixIcon;

  TripFormFields(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.validator,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: const Color.fromARGB(255, 90, 87, 87)),
        prefixIcon: prefixIcon,
      ),
      validator: validator,
    );
  }
}

// AppBar---
class forAppBar extends StatelessWidget {
  final String title;
  const forAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.white,
      backgroundColor: Color.fromARGB(255, 1, 1, 19),
      title: Text(title),
    );
  }
}
