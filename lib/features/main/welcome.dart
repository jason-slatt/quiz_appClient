// ignore_for_file: deprecated_member_use

import 'package:HGArena/features/main/leaderboard.dart';
import 'package:HGArena/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:HGArena/constant/global_variables.dart';
import 'package:HGArena/features/main/home.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class Welcome extends StatefulWidget {
  static const routeName = '/welcome';
  final String userId;
  const Welcome({super.key, required this.userId});

  @override
  State<Welcome> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<Welcome> {
  int? Rank;
  int? Points;
  final List<Map<String, dynamic>> categories = GlobalVariable().categories;

  @override
  void initState() {
    super.initState();
    fetchUserDate();
  }

  void fetchUserDate() async {
    final userData = await getUserRankAndPoints(widget.userId);
    setState(() {
      Rank = userData?['rank'];
      Points = userData?['totalPoints'];
    });
  }
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
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final username = userProvider.username ?? "Guest";
    final userphoto = userProvider.photoURL ?? '';

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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, $username",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "Let’s make this day productive",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                  CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.orange[100],
                      backgroundImage: userphoto.isNotEmpty
                          ? NetworkImage(userphoto)
                          : const AssetImage("assets/arena1.jpg")
                              as ImageProvider),
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
                    GestureDetector(
                      child: _statCard(Icons.emoji_events, "Ranking", "$Rank"),
                      onTap: () {
                        Navigator.pushNamed(
                            context, LeaderboardScreen.routeName);
                      },
                    ),
                    _statCard(Icons.monetization_on, "Points", "$Points"),
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
                        Navigator.pushNamed(context, Home.routeName,
                            arguments: [
                              categories[index]['id'],
                              categories[index]['name']
                            ]);
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
            Text(value,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue)),
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
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(subtitle, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
