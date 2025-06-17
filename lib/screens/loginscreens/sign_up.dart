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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A1A2E),
              Color(0xFF16213E),
              Color(0xFF0F3460),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4ECDC4).withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Icon(
                                    Icons.person_add,
                                    size: 40,
                                    color: Color(0xFF4ECDC4),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Join MY TRIPS",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Create your account to start planning",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20),

                          // Email Field
                          Text(
                            "Email Address",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          TextFormfieldData(
                            hintText: "Enter your email",
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
                          SizedBox(height: 20),

                          // Password Field
                          Text(
                            "Password",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          TextFormfieldData(
                            hintText: "Create a password",
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          // Name Field
                          Text(
                            "Full Name",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          TextFormfieldData(
                            hintText: "Enter your full name",
                            controller: _nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          // Home City Field
                          Text(
                            "Home City",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          TextFormfieldData(
                            hintText: "Enter your home city",
                            controller: _homecityController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your home city';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 40),

                          // Create Account Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_emailController.text.isNotEmpty &&
                                    _passwordController.text.isNotEmpty &&
                                    _nameController.text.isNotEmpty &&
                                    _homecityController.text.isNotEmpty) {
                                  createAccount();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Please fill all fields"),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF4ECDC4),
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 5,
                              ),
                              child: Text(
                                "Create Account",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BottomNav()));
      addUserProfile(user);
    }
  }
}
