
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quiz_app/constant/global_variables.dart';
import 'package:quiz_app/features/auth/screens/auth_screen.dart';
import 'package:quiz_app/features/auth/screens/signUp_screen.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import 'forgetPassword_screen.dart';



class LoginScreen extends StatefulWidget {
  static const routeName = '/signIn_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _logInFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //AuthService authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  /*void signInUser() {
    authService.signInUser(
        context: context,
        email: _emailContreoller.text,
        password: _passwordContreoller.text);
  }*/

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                                  ))
                          ),
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
                                  controller: _emailController,
                                  hintext: 'Email',
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.010,
                                ),
                                CustomTextField(
                                    controller: _passwordController,
                                    hintext: 'password'),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.010,
                                ),
                                CustomButton(
                                    text: 'log In',
                                    onTap: () {
                                      if(_logInFormKey.currentState!.validate()){
                                        //signInUser();
                                      }

                                    }),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.010,
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
              ]
            ),
          ),
        ),
      ),
    );
  }
}
