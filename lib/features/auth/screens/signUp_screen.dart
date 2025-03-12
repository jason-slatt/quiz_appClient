import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:HGArena/constant/global_variables.dart';
import 'package:HGArena/features/auth/screens/signIn_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/custom_button.dart';

class SignupScreen extends StatefulWidget {
  static const routeNamed = '/signUP_screen';
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _signupField = GlobalKey<FormState>();

  @override
  void dispose() {
    // Dispose the controllers to avoid memory leaks
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  // Sign-up function
  Future<void> _signUp() async {
    if (!_signupField.currentState!.validate()) {
      // If form is not valid, return early
      return;
    }

    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String username = usernameController.text.trim();

    try {
      // Show loading indicator while signing up
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()),
      );

      // Create user with email and password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Store username and other data in Firestore
        await _firestore.collection("users").doc(user.uid).set({
          "username": username,
          "email": user.email,
          "uid": user.uid,
          "createdAt": FieldValue.serverTimestamp(),
        });

        // Send email verification
        await user.sendEmailVerification();

        // Hide loading indicator and show success message
        Navigator.pop(context);
        _showVerificationDialog(user.email);
      }
    } on FirebaseAuthException catch (e) {
      // Handle error
      Navigator.pop(context); // Close loading indicator
      _showErrorDialog(e.message ?? "Sign-up failed");
    }
  }

  // Show email verification dialog
  void _showVerificationDialog(String? email) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Verify Your Email"),
        content: Text(
            "A verification email has been sent to $email. Please verify before logging in."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          )
        ],
      ),
    );
  }

  // Show error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  final TextEditingController _emailController = TextEditingController();
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
            filter: ImageFilter.blur(sigmaX: 300, sigmaY: 300),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 60,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: GlobalVariable.backgroundColor,
                            child: Icon(
                              Icons.interests,
                              color: Colors.blue,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5, right: 20),
                            child: Text(
                              'Welcome \u{1F44B} to IQ ARENA ',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: GlobalVariable.backgroundColor,
                                  fontWeight: FontWeight.bold),
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
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.010,
                          ),
                          Form(
                            key: _signupField,
                            child: Column(
                              children: [
                                _emailWidget(),
                                // CustomTextField(
                                //   controller: _emailController,
                                //   hintext: 'Email',
                                // ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.010,
                                ),
                                _nameWidget(),
                                // CustomTextField(
                                //     controller: _nameController,
                                //     hintext: 'Name'),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.010,
                                ),
                                _passwordWidget(),
                                // CustomTextField(
                                //     controller: _passwordController,
                                //     hintext: 'Password'),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.010,
                                ),
                                //_confirmPasswordWidget(),
                                // CustomTextField(
                                //     controller: _confirmpasswordController,
                                //     hintext: 'Confirm Password'),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.010,
                                ),
                                CustomButton(
                                    text: 'Sign Up',
                                    onTap: () {
                                      if (_signupField.currentState!
                                          .validate()) {
                                        _signUp();
                                      }
                                    }),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.010,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 40),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, LoginScreen.routeName);
                                      },
                                      child: const Text(
                                        'log In',
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _passwordWidget() {
    return TextFormField(
      obscureText: false,
      controller: passwordController,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Password require';
        } else if (val.length < 8) {
          return 'password must be at least  8 characters';
        }
        return null;
      },
      decoration: const InputDecoration(
        hintText: 'Enter password',
        labelText: 'password',
        icon: Icon(Icons.lock_clock_outlined),
      ),
    );
  }

  /* TextFormField _confirmPasswordWidget() {
    return TextFormField(
      obscureText: false,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'password is require';
        } else if (val != _password) {
          return 'password does not match';
        }
        return null;
      },
      onChanged: (value) {
      },
      decoration: const InputDecoration(
        hintText: 'Confirm Password',
        labelText: 'Confirm Password',
        icon: Icon(Icons.lock_clock_outlined),
      ),
    );
  }*/

  TextFormField _emailWidget() {
    return TextFormField(
      obscureText: false,
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Email require';
        } else if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(val)) {
          return 'please enter a valid email address';
        }
        return null;
      },
      decoration: const InputDecoration(
        hintText: 'Enter email',
        labelText: 'Email',
        icon: Icon(Icons.email_outlined),
      ),
    );
  }

  TextFormField _nameWidget() {
    return TextFormField(
      obscureText: false,
      controller: usernameController,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Name require';
        }
        return null;
      },
      onSaved: (newValue) {},
      decoration: const InputDecoration(
        hintText: 'Enter your name',
        labelText: 'name',
        icon: Icon(Icons.person),
      ),
    );
  }
}
