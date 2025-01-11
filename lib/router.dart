import 'package:flutter/material.dart';
import 'package:quiz_app/features/auth/screens/auth_screen.dart';
import 'package:quiz_app/features/auth/screens/forgetPassword_screen.dart';
import 'package:quiz_app/features/auth/screens/signIn_in.dart';
import 'package:quiz_app/features/auth/screens/signUp_screen.dart';

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

    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
              body: Center(
                child: Text("THIS PAGE DOES NOT EXIST"),
              )));
  }
}