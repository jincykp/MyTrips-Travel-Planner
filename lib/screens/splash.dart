import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_trips/SCREENS/onboardingscreens/onboardingone.dart';

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "MY TRIPS",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Center(
                child: Container(
                  child: Lottie.asset("assets/animations/travel1.json"),
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
    // WidgetsFlutterBinding.ensureInitialized();
    // final dir = await path.getApplicationDocumentsDirectory();
    // Hive.init(dir.path);
    // Hive.registerAdapter(UserModelAdapter());
    // Hive.registerAdapter(TripModelAdapter());
    // await Hive.initFlutter('hive_db');
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (contex) => OnBoardingone()));
  }
}
