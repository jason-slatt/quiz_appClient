import 'dart:ui';

import 'package:HGArena/features/main/welcome.dart';
import 'package:flutter/material.dart';
import 'package:HGArena/constant/global_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // If the user cancels the sign-in process, return null
      if (googleUser == null) {
        return null;
      }

      // Obtain the authentication details from the Google user
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential for Firebase Authentication using the Google auth details
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credentials
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      print("UserCredential Response: $userCredential");

      User? user = userCredential.user;

      print("User Details: $user");

      if (user != null) {
        // Save user details in Provider
        Provider.of<UserProvider>(context, listen: false).setUser(
            user.displayName ?? "Guest",
            user.email ?? "No email",
            user.uid,
            user.photoURL ?? "");
        Navigator.pushNamed(context, Welcome.routeName);
      }

      // Return the Firebase user
      return userCredential.user;
    } catch (e) {
      print("Error during Google Sign-In: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await googleSignIn.signOut();
    await _auth.signOut();
    print("User signed out");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/intro.jpg'), fit: BoxFit.cover)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Stack(
              children: [
                const Positioned(
                  bottom: 50,
                  top: 350,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 80, left: 0),
                        child: Padding(
                          padding: EdgeInsets.only(right: 50, left: 0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: GlobalVariable.backgroundColor,
                                child:
                                    Icon(Icons.interests, color: Colors.blue),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10, right: 15),
                                child: Text(
                                  'IQ ARENA',
                                  style: TextStyle(
                                      color: GlobalVariable.backgroundColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 12, right: 50),
                        child: Text(
                          'Challenge\nlearn & thrive \u{1F393}.',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 70),
                  child: Align(
                    heightFactor: 24,
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                          padding: const EdgeInsets.only(
                              top: 20, right: 60, bottom: 20, left: 60),
                          height: 40,
                          onPressed: () => signInWithGoogle(context),
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "join with Google",
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    ));
  }
}
