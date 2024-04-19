import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 145, 145, 190),
        foregroundColor: Colors.white,
        title: Text(
          "Contact Us",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
        child: Column(
          children: [
            Container(
              child: Lottie.asset("assets/animations/contact.json"),
            ),
            SizedBox(
              height: 170,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Company Name : MY TRIPS",
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Email : mytrips@gmail.com",
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
