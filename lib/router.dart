
import 'package:flutter/material.dart';
import 'package:quiz_app/features/auth/screens/auth_screen.dart';
import 'package:quiz_app/features/auth/screens/forgetPassword_screen.dart';
import 'package:quiz_app/features/auth/screens/signIn_in.dart';
import 'package:quiz_app/features/auth/screens/signUp_screen.dart';
import 'package:quiz_app/features/main/complete.dart';
import 'package:quiz_app/features/main/home.dart';
import 'package:quiz_app/features/main/welcome.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch(routeSettings.name){
    case AuthScreen.routeName :
      return MaterialPageRoute(builder: (_) => const AuthScreen());
    case LoginScreen.routeName :
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    case SignupScreen.routeNamed:
      return MaterialPageRoute(builder: (_) => const SignupScreen());
    case ForgetPasswordScreen.routeNamed :
      return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());
    case Welcome.routeName :
      return MaterialPageRoute(builder: (_) => const Welcome());
    case Completed.routeName:
      return MaterialPageRoute(
        builder: (context) {
          final args = routeSettings.arguments as  List<Object>;
          return Completed(args: args); // Pass arguments explicitly
        },
      );

    case Home.routeName :
      final category = routeSettings.arguments as List<dynamic>;
      return MaterialPageRoute(builder: (_) =>  Home(args: category));
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
              body: Center(
                child: Text("THIS PAGE DOES NOT EXIST"),
              )));
  }
}