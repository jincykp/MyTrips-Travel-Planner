import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 145, 145, 190),
        foregroundColor: Colors.white,
        title: Text(
          "About Us",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "About Us",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  ),
                ],
              ),
              Text(
                  "Welcome to MY TRIPS - your personalized travel planner designed to make journey planning effortless, memorable, and enjoyable!"),
              Row(
                children: [
                  Text(
                    "Who We Are",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  )
                ],
              ),
              Text(
                  "We are a passionate team of travel enthusiasts, developers, and designers committed to transforming the way you plan and experience your trips. Our mission is to empower travelers like you to explore the world with confidence, creativity, and convenience."),
              Row(
                children: [
                  Text(
                    "Our Vision",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  ),
                ],
              ),
              Text(
                  "In a world filled with endless travel possibilities, we believe that every trip should be unique, meaningful, and tailored to your preferences. MY TRIPS is more than just a travel planner; it's your digital travel companion that helps you discover, plan, and relive your adventures, one destination at a time."),
              Row(
                children: [
                  Text(
                    "What We Offer",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  ),
                ],
              ),
              Text(
                  '''*Easy Trip Planning: Plan your trips effortlessly with our intuitive and user-friendly interface. Create detailed itineraries, add activities, and customize your travel plans to suit your interests and schedule.

* Discover New Destinations: Explore a curated list of destinations, attractions, and experiences to inspire your next adventure. From popular tourist spots to hidden gems, we've got you covered!

*Organize & Sync: Keep all your travel plans, bookings, and important documents in one place. Sync your itineraries across devices and access them anytime, anywhere.

* Share & Collaborate: Share your travel plans with friends, family, or travel companions and collaborate in real-time to create the perfect itinerary together.'''),
              Row(
                children: [
                  Text(
                    "Why Choose MY TRIPS",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  ),
                ],
              ),
              Text(
                  '''* Personalized Recommendations: Receive personalized travel recommendations based on your interests, preferences, and past trips to make planning even more enjoyable.

* Travel Tips & Insights: Stay informed and inspired with travel tips, insights, and insider information curated by our team of travel experts.

* Privacy & Security: We prioritize your privacy and data security, ensuring that your travel plans and personal information remain confidential and secure. '''),
              Row(
                children: [
                  Text(
                    "Get In Touch",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  ),
                ],
              ),
              Text(
                  "We value your feedback and suggestions! Whether you have questions, ideas for new features, or just want to share your travel stories, we'd love to hear from you. Feel free to contact us anytime."),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      "Thank You for Choosing MY TRIPS",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    ),
                  ),
                ],
              ),
              Text(
                  "We are grateful for your trust and support. We hope MY TRIPS becomes your go-to travel planner, helping you plan, organize, and enjoy unforgettable journeys for years to come. "),
            ],
          ),
        ),
      ),
    );
  }
}
