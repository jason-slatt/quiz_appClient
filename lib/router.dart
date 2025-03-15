import 'package:hq_arena/features/main/leaderboard.dart';
import 'package:flutter/material.dart';
import 'package:hq_arena/features/auth/screens/auth_screen.dart';
import 'package:hq_arena/features/main/complete.dart';
import 'package:hq_arena/features/main/home.dart';
import 'package:hq_arena/features/main/welcome.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AuthScreen());
    case Welcome.routeName:
      final userId = routeSettings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => Welcome(
                userId: userId,
              ));
    case LeaderboardScreen.routeName:
      return MaterialPageRoute(builder: (_) => const LeaderboardScreen());
    case Completed.routeName:
      return MaterialPageRoute(
        builder: (context) {
          final args = routeSettings.arguments as List<Object>;
          return Completed(args: args); // Pass arguments explicitly
        },
      );

    case Home.routeName:
      final category = routeSettings.arguments as List<dynamic>;
      return MaterialPageRoute(builder: (_) => Home(args: category));
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                  body: Center(
                child: Text("THIS PAGE DOES NOT EXIST"),
              )));
  }
}
