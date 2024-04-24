import 'package:flutter/material.dart';

class TermsconditionScreen extends StatelessWidget {
  const TermsconditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 145, 145, 190),
        foregroundColor: Colors.white,
        title: Text(
          "Terms And Conditions",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "1. Acceptance of Terms",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    "By accessing or using the MY TRIPS app, you agree to comply with and be bound by these Terms and Conditions. If you do not agree to these terms, please do not use the app."),
                Text(
                  "2. Description of Service",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    "MY TRIPS is a travel planner app designed to assist users in planning, organizing, and managing their trips, including itinerary planning, booking accommodations, and discovering attractions."),
                Text(
                  "1. User Accounts",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    '''a. Users must register for an account to access certain features of the app.
b. Users are responsible for maintaining the confidentiality of their account credentials and are liable for any activities conducted through their account.'''),
                Text(
                  "4. User Responsibilities",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    ''' a. Users are responsible for the accuracy and completeness of the information provided.
b. Users must comply with all applicable laws and regulations while using the app.
c. Users must not use the app for any unlawful or unauthorized purposes.'''),
                Text(
                  "5. Privacy Policy",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    '''Our Privacy Policy governs the collection, use, and disclosure of personal information provided by users. By using the app, you consent to the collection and use of your personal information as described in the Privacy Policy. '''),
                Text(
                  "6. Intellectual Property",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    '''a. All content, features, and functionalities of the app are the property of MY TRIPS or its licensors and are protected by copyright, trademark, and other intellectual property laws.
b. Users are granted a limited, non-exclusive, non-transferable license to use the app for personal, non-commercial purposes only. '''),
                Text(
                  "7. Limitation of Liability",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    ''' a. MY TRIPS shall not be liable for any direct, indirect, incidental, special, or consequential damages arising out of or in connection with the use or inability to use the app.
b. MY TRIPS does not guarantee the accuracy, completeness, or reliability of any content or information provided through the app.'''),
                Text(
                  "8. Termination",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    '''MY TRIPS reserves the right to suspend or terminate access to the app at any time without prior notice for any reason, including, but not limited to, violation of these Terms and Conditions. '''),
                Text(
                  "9. Changes to Terms and Conditions",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    ''' MY TRIPS may update or modify these Terms and Conditions at any time without prior notice. Continued use of the app following any such changes constitutes acceptance of the revised Terms and Conditions.'''),
                Text(
                  "10. Governing Law",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    '''These Terms and Conditions shall be governed by and construed in accordance with the laws of [Jurisdiction], without regard to its conflict of laws principles. '''),
                Text(
                  "11. Contact Information",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    '''For any questions or concerns regarding these Terms and Conditions, please contact us at mytrips@gmail.com  ''')
              ]),
        ),
      ),
    );
  }
}
