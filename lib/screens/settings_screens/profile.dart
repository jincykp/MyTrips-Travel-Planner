import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_trips/SCREENS/loginscreens/signin.dart';
import 'package:my_trips/database/functions/user_db_functions.dart';
import 'package:my_trips/database/model/data_model.dart';
import 'package:my_trips/screens/settings_screens/about_us.dart';
import 'package:my_trips/screens/settings_screens/contact_us.dart';
import 'package:my_trips/screens/settings_screens/privacy_policy.dart';
import 'package:my_trips/screens/settings_screens/terms_conditions.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserModel userModel;
  String? image;

  @override
  void initState() {
    super.initState();
    getAllUSerProfile();
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
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text("PROFILE"),
        backgroundColor: Color.fromARGB(255, 6, 6, 37),
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 145, 145, 190),
        child: ListView(
          children: [
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
                      builder: (context) => PrivacyPolicyScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text(
                "About Us",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_support_sharp),
              title: Text(
                "Contact Us",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.note),
              title: Text(
                "Terms and Conditions",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TermsconditionScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Card(
          color: Color.fromARGB(255, 6, 6, 37),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: 350,
            height: 550,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                buildAvatar(),
                SizedBox(height: 10),
                Expanded(
                  child: buildUserDetails(),
                ),
                buildSignOutButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAvatar() {
    return Stack(
      children: [
        CircleAvatar(
          backgroundColor: const Color.fromARGB(255, 106, 106, 173),
          backgroundImage: image != null
              ? FileImage(File(image!))
              : const AssetImage('') as ImageProvider,
          radius: 79,
          child: image == null
              ? IconButton(
                  onPressed: () {
                    getimage();
                  },
                  icon: Icon(
                    Icons.person,
                    size: 80,
                  ))
              : null,
        ),
        Positioned(
            bottom: -5,
            right: -4,
            child: IconButton(
                onPressed: () {
                  getimage();
                },
                icon: Icon(Icons.add_a_photo_outlined,
                    color: Color.fromARGB(255, 233, 231, 231), size: 45)))
      ],
    );
    // return image == null
    //     ? CircleAvatar(
    //         backgroundColor: Color.fromARGB(255, 106, 106, 173),
    //         radius: 70,
    //         child: IconButton(
    //           onPressed: () {
    //             getimage();
    //           },
    //           icon: Icon(
    //             Icons.person,
    //             color: Colors.purple,
    //             size: 80,
    //           ),
    //         ),
    //       )
    //     : CircleAvatar(
    //         radius: 60,
    //         backgroundImage: FileImage(File(image!)),
    //       );
  }

  Widget buildUserDetails() {
    return ValueListenableBuilder<List<UserModel>>(
      valueListenable: userListNotifier,
      builder: (context, userList, _) {
        if (userList.isNotEmpty) {
          final user = userList.last;
          return Column(
            children: [
              buildListTile('Name:', user.name),
              Divider(thickness: 2),
              buildListTile('Email id:', user.email),
              Divider(thickness: 2),
              buildListTile('Home City:', user.homecity),
              Divider(thickness: 2),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget buildListTile(String label, String value) {
    return ListTile(
      title: Text(label + ' $value', style: TextStyle(color: Colors.white)),
    );
  }

  Widget buildSignOutButton() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue),
      ),
      onPressed: () {
        showAlertDialog(context);
      },
      child: Text("Sign Out", style: TextStyle(color: Colors.white)),
    );
  }

  void getimage() async {
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
        image: pickedImage.path,
      );
      await addUserImage(userModel);
    }
  }

  void showAlertDialog(BuildContext context) {
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
          (route) => false,
        );
      },
    );

    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.grey,
      title: Text("Attention!!!"),
      content: Text("Sign out of your account?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
