import 'package:HGArena/utils/helpers.dart';
import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  static const String routeName = '/leaderboard';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Leaderboard"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: getLeaderboard(), // Fetching the leaderboard
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No leaderboard data available"));
          } else {
            final leaderboard = snapshot.data!;
            return ListView.builder(
              itemCount: leaderboard.length,
              itemBuilder: (context, index) {
                final player = leaderboard[index];
                return ListTile(
                  leading: Text("${index + 1}"), // Display rank
                  title: Text(player['username']),
                  trailing: Text("${player['totalPoints']} points"),
                );
              },
            );
          }
        },
      ),
    );
  }
}
