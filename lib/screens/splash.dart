import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_trips/SCREENS/onboardingscreens/onboardingone.dart';
import 'package:my_trips/screens/homepage.dart';
import 'package:my_trips/screens/onboardingscreens/onboardingtwo.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    gotoLogin();
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 6, 6, 37),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "MY TRIPS",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                ),
              ),
              SizedBox(height: 50),
              Center(
                child: Container(
                  child: Lottie.asset(
                      "assets/animations/Animation - 1713874576773.json"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> gotoLogin() async {
    await Future.delayed(Duration(seconds: 7));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (contex) => OnBoardingTwo()));
  }
}
