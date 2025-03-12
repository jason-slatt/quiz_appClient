import 'dart:ui';

import 'package:HGArena/features/main/welcome.dart';
import 'package:flutter/material.dart';
import 'package:HGArena/constant/global_variables.dart';
import 'package:HGArena/features/auth/screens/auth_screen.dart';
import 'package:HGArena/features/auth/screens/signUp_screen.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import 'forgetPassword_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/signIn_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _logInFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  //AuthService authService = AuthService();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void _signIn() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      User? user = userCredential.user;

      if (user != null) {
        // Check if email is verified
        if (!user.emailVerified) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text("Please verify your email before logging in.")),
          );
          await _auth.signOut();
          return;
        }

        // Fetch username from Firestore
        DocumentSnapshot userDoc =
            await _firestore.collection("users").doc(user.uid).get();

        if (userDoc.exists) {
          // Store user data in Provider
          Provider.of<UserProvider>(context, listen: false).setUser(
              userDoc["username"],
              userDoc["email"],
              user.uid,
              user.photoURL ?? '');
        }

        // Navigate to home screen with username
        Navigator.pushNamed(context, Welcome.routeName);
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? "Sign-in failed")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/intro.jpg'), fit: BoxFit.cover),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: GlobalVariable.backgroundColor,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AuthScreen.routeName);
                                },
                                icon: const Icon(
                                  Icons.interests,
                                  color: Colors.blue,
                                ))),
                        const Padding(
                          padding: EdgeInsets.only(left: 10, right: 20),
                          child: Text(
                            'WelcomeBack \u{1F60A} to IQ ARENA',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: GlobalVariable.backgroundColor),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    color: GlobalVariable.backgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Container(
                            width: 70,
                            height: 5,
                            decoration: BoxDecoration(
                              color: GlobalVariable.backgroundColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.080,
                        ),
                        const Text(
                          'log In',
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.010,
                        ),
                        Form(
                          key: _logInFormKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: emailController,
                                hintext: 'Email',
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.010,
                              ),
                              CustomTextField(
                                  controller: passwordController,
                                  hintext: 'password'),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.010,
                              ),
                              CustomButton(
                                  text: 'log In',
                                  onTap: () {
                                    if (_logInFormKey.currentState!
                                        .validate()) {
                                      _signIn();
                                    }
                                  }),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.010,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context,
                                        ForgetPasswordScreen.routeNamed);
                                  },
                                  child: const Text(
                                    'Forgot password?',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  )),
                              const SizedBox(
                                height: 80,
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 40),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, SignupScreen.routeNamed);
                                    },
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
