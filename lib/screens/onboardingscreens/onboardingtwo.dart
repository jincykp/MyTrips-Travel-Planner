import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:my_trips/SCREENS/onboardingscreens/onboardingthree.dart';

class OnBoardingTwo extends StatelessWidget {
  const OnBoardingTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 6, 6, 37),
      body: Column(
        children: [
          Expanded(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 150, 10.0, 16.0),
                    child: Text(
                      "'''The World Awaits! Let's Plan Your Next Escape'''",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  // Container(
                  //   width: 400,
                  //   height: 400,
                  //   alignment: Alignment.bottomCenter,
                  //   child: Lottie.asset("assets/animations/location.json"),
                  // )
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
                            builder: (context) => OnBoardingThree()));
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
