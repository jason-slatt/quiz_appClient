
import 'package:flutter/material.dart';
import 'package:quiz_app/constant/global_variables.dart';
import 'package:quiz_app/features/main/home.dart';

class Welcome extends StatefulWidget {
  static const routeName = '/welcome';
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<Welcome> {
  final List<Map<String, dynamic>> categories = GlobalVariable().categories;
 /* List categories = [];
  Future api() async {
    final response = await http.get(Uri.parse("https://opentdb.com/api_category.php"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['trivia_categories'];
      print(data);
      setState(() {
        categories= data;
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, John",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Let’s make this day productive",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.orange[100],
                    child: const Icon(Icons.person, size: 40, color: Colors.orange),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Stats Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _statCard(Icons.emoji_events, "Ranking", "348"),
                    _statCard(Icons.monetization_on, "Points", "1209"),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // "Let's Play" Title
              const Text(
                "Let's play",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              // Quiz Categories Grid
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to Gameplay Screen with selected category
                        Navigator.pushNamed(context, Home.routeName , arguments:[categories[index]['id'],categories[index]['name']]);

                      },
                      child: _quizCategory(
                        categories[index]['icon'],
                        categories[index]['name'],
                        "${categories[index]['questions']} questions",
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statCard(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.amber, size: 30),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.grey)),
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
          ],
        ),
      ],
    );
  }

  Widget _quizCategory(IconData icon, String title, String subtitle) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: Colors.orange),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(subtitle, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
