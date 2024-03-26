import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_trips/SCREENS/Homepage.dart';
import 'package:my_trips/database/functions/user_db_functions.dart';
import 'package:my_trips/database/model/data_model.dart';
import 'package:my_trips/screens/loginscreens/support.dart';

class CreateScreen extends StatefulWidget {
  CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _homecityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late Box box1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 1, 1, 19),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 1, 1, 19),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "MY TRIPS",
                      style: TextStyle(
                          color: Color.fromARGB(255, 248, 242, 242),
                          fontSize: 35),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      children: [
                        Text(
                          "Email Address:",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 7),
                    TextFormfieldData(
                      hintText: "Email id",
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        final bool isValid =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value);
                        if (!isValid) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "Password:",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    TextFormfieldData(
                      hintText: "password",
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    TextFormfieldData(
                      hintText: 'name',
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Text(
                          "HomeCity:",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    TextFormfieldData(
                      hintText: 'homecity',
                      controller: _homecityController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter homecity';
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {
                        if (_emailController.text.isNotEmpty ||
                            _passwordController.text.isNotEmpty ||
                            _nameController.text.isNotEmpty ||
                            _homecityController.text.isNotEmpty) {
                          createAccount();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Please enter all details")));
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      child: Text(
                        "Create Account",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  createAccount() {
    final useremail = _emailController.text.trim();
    final userpassword = _passwordController.text.trim();
    final username = _nameController.text.trim();
    final userhomecity = _homecityController.text.trim();
    if (_formKey.currentState!.validate()) {
      final user = UserModel(
          email: useremail,
          password: userpassword,
          name: username,
          homecity: userhomecity);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => BottomNav()));
      addUserProfile(user);
    }
  }
}
