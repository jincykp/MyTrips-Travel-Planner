import 'package:flutter/material.dart';
import 'package:my_trips/SCREENS/Homepage.dart';
import 'package:lottie/lottie.dart';
import 'package:my_trips/screens/loginscreens/create.dart';
import 'package:my_trips/screens/loginscreens/login.dart';
import 'package:my_trips/screens/onboardingscreens/onboardingtwo.dart';

class OnBoardingone extends StatefulWidget {
  const OnBoardingone({super.key});

  @override
  State<OnBoardingone> createState() => _OnBoardingoneState();
}

class _OnBoardingoneState extends State<OnBoardingone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 6, 6, 37),
      body: Column(
        children: [
          Expanded(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "'Embark on your  journey with our travel app, where every destination is a new adventure waiting to unfold'",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                      ),
                    ),
                  ),
                  Container(
                    child: Lottie.asset(
                        "assets/animations/Animation - 1709649193707.json",
                        height: 200,
                        width: 200),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OnBoardingTwo()));
                  },
                  child: Text(
                    'Next>>>',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
