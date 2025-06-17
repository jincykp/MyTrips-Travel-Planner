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

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late UserModel userModel;
  String? image;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeOutBack));

    getAllUSerProfile();
    getUserImage().then((images) {
      if (images.isNotEmpty) {
        setState(() {
          userModel = images.last;
          image = userModel.image;
        });
      }
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
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
              _buildAppBar(),
              Expanded(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: _buildProfileContent(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      endDrawer: _buildDrawer(),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'My Profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Builder(
            builder: (context) => GestureDetector(
              onTap: () => Scaffold.of(context).openEndDrawer(),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildProfileHeader(),
          const SizedBox(height: 30),
          _buildUserInfoCard(),
          const SizedBox(height: 30),
          _buildSignOutButton(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          _buildAvatar(),
          const SizedBox(height: 16),
          ValueListenableBuilder<List<UserModel>>(
            valueListenable: userListNotifier,
            builder: (context, userList, _) {
              if (userList.isNotEmpty) {
                final user = userList.last;
                return Text(
                  user.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }
              return const Text(
                'Welcome',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF4A90E2), Color(0xFF7B68EE)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4A90E2).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: image != null ? FileImage(File(image!)) : null,
            radius: 60,
            child: image == null
                ? const Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white,
                  )
                : null,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: getimage,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF4A90E2),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfoCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: ValueListenableBuilder<List<UserModel>>(
        valueListenable: userListNotifier,
        builder: (context, userList, _) {
          if (userList.isNotEmpty) {
            final user = userList.last;
            return Column(
              children: [
                _buildInfoTile(Icons.person_outline, 'Name', user.name),
                _buildDivider(),
                _buildInfoTile(Icons.email_outlined, 'Email', user.email),
                _buildDivider(),
                _buildInfoTile(
                    Icons.location_city_outlined, 'Home City', user.homecity),
              ],
            );
          }
          return const Padding(
            padding: EdgeInsets.all(40),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4A90E2)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF4A90E2).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF4A90E2),
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.white.withOpacity(0.1),
      thickness: 1,
      indent: 20,
      endIndent: 20,
      height: 1,
    );
  }

  Widget _buildSignOutButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE74C3C), Color(0xFFC0392B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE74C3C).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => showAlertDialog(context),
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Sign Out',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF1A1A2E),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4A90E2).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.settings,
                      color: Color(0xFF4A90E2),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    "Settings",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white24),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _buildDrawerItem(
                    icon: Icons.privacy_tip_outlined,
                    title: "Privacy Policy",
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PrivacyPolicyScreen()),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.info_outline,
                    title: "About Us",
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AboutScreen()),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.contact_support_outlined,
                    title: "Contact Us",
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContactScreen()),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.description_outlined,
                    title: "Terms and Conditions",
                    onTap: () {
                      Navigator.pop(context);
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
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.transparent,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.white70,
          size: 22,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hoverColor: Colors.white.withOpacity(0.05),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
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
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A1A2E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.white.withOpacity(0.1)),
          ),
          title: Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.orange,
                size: 28,
              ),
              const SizedBox(width: 12),
              const Text(
                "Confirm Sign Out",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: const Text(
            "Are you sure you want to sign out of your account?",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFE74C3C), Color(0xFFC0392B)],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (ctx1) => SigninScreen()),
                    (route) => false,
                  );
                },
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Sign Out",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
