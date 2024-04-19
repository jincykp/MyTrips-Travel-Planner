import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_trips/SCREENS/loginscreens/signin.dart';
import 'package:my_trips/database/functions/user_db_functions.dart';

import 'package:my_trips/database/model/data_model.dart';
import 'package:my_trips/screens/settings_screens/about_us.dart';
import 'package:my_trips/screens/settings_screens/contact_us.dart';
import 'package:my_trips/screens/settings_screens/privacy_policy.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserModel userModel;
  String? image;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserImage().then((images) {
      if (images.isNotEmpty) {
        setState(() {
          userModel = images.last;
          image = userModel.image;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 145, 145, 190),
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          "PROFILE",
        ),
        backgroundColor: Color.fromARGB(255, 6, 6, 37),
      ),
      drawer: Padding(
        padding: const EdgeInsets.fromLTRB(0, 15, 15, 15),
        child: Drawer(
          backgroundColor: Color.fromARGB(255, 145, 145, 190),
          child: ListView(children: [
            ListTile(
              leading: Icon(
                Icons.settings,
                size: 35,
              ),
              title: Text(
                "Settings",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            ListTile(
                leading: Icon(Icons.privacy_tip),
                title: Text(
                  "Privacy Policy",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrivacyPolicyScreen()));
                }),
            ListTile(
                leading: Icon(Icons.info),
                title: Text(
                  "About Us",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutScreen()));
                }),
            ListTile(
                leading: Icon(Icons.contact_support_sharp),
                title: Text(
                  "Contact Us",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ContactScreen()));
                })
          ]),
        ),
      ),
      body: Center(
        child: Card(
          color: Color.fromARGB(255, 6, 6, 37),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.zero),
          ),
          child: Container(
            width: 350,
            height: 550,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,
                ),
                image == null
                    ? CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 106, 106, 173),
                        radius: 60,
                        child: IconButton(
                          onPressed: () {
                            getimage();
                          },
                          icon: Icon(
                            Icons.person,
                            color: Colors.purple,
                            size: 80,
                          ),
                        ),
                      )
                    : CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(
                          (File(image!)),
                        ),
                      ),
                SizedBox(height: 10),
                Expanded(
                  child: ValueListenableBuilder<List<UserModel>>(
                    valueListenable: userListNotifier,
                    builder: (context, userList, _) {
                      if (userList.isNotEmpty) {
                        final user = userList.last;
                        return Column(
                          children: [
                            ListTile(
                              title: Text('Name: ${user.name}',
                                  style: TextStyle(color: Colors.white)),
                            ),
                            Divider(thickness: 2),
                            ListTile(
                              title: Text(
                                'Email id: ${user.email}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Divider(thickness: 2),
                            ListTile(
                              title: Text('Home City: ${user.homecity}',
                                  style: TextStyle(color: Colors.white)),
                            ),
                            Divider(thickness: 2),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Row(
                            //     children: [
                            //       Text(
                            //         "Settings",
                            //         style: TextStyle(
                            //             color: Colors.white,
                            //             fontWeight: FontWeight.bold),
                            //       ),
                            //       IconButton(
                            //           onPressed: () {},
                            //           icon: Icon(
                            //             Icons.settings,
                            //             color: const Color.fromARGB(
                            //                 255, 122, 112, 112),
                            //           )),
                            //     ],
                            //   ),
                            // ),
                            // Divider(thickness: 2),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    onPressed: () {
                      showAlertDialog(context);
                    },
                    child:
                        Text("Sign Out", style: TextStyle(color: Colors.white)))
              ],
            ),
          ),
        ),
      ),
    );
  }

  getimage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = pickedImage.path;
      });

      userModel = UserModel(
          email: userModel.email,
          password: userModel.password,
          name: userModel.name,
          homecity: userModel.homecity,
          image: pickedImage.path);
      await addUserImage(userModel);
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Sign Out"),
      onPressed: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx1) => SigninScreen()),
            (route) => false);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.grey,
      title: Text("Attention!!!"),
      content: Text("Sign out of your account?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
