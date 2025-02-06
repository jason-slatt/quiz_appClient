
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:HGArena/constant/global_variables.dart';
import 'package:HGArena/features/auth/screens/signIn_in.dart';

import '../widgets/custom_button.dart';

class SignupScreen extends StatefulWidget {
  static const routeNamed = '/signUP_screen';
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _signupField = GlobalKey<FormState>();
  final passkey = GlobalKey();

  final bool _autoValide = false;
  final bool _isloading = false;

  String _email = '';
  final String _name = '';
  String _password = '';
  String _confirmPassword = '';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // final TextEditingController _confirmpasswordController =
  //     TextEditingController();
  //AuthService authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    // _confirmpasswordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  /* void signUpUser() {
    authService.signUpUser(
        context: context,
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text);
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
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
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
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.080,
                          ),
                          const Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.010,
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
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height *
                                      0.010,
                                ),
                                _nameWidget(),
                                // CustomTextField(
                                //     controller: _nameController,
                                //     hintext: 'Name'),
                                SizedBox(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height *
                                      0.010,
                                ),
                                _passwordWidget(),
                                // CustomTextField(
                                //     controller: _passwordController,
                                //     hintext: 'Password'),
                                SizedBox(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height *
                                      0.010,
                                ),
                                _confirmPasswordWidget(),
                                // CustomTextField(
                                //     controller: _confirmpasswordController,
                                //     hintext: 'Confirm Password'),
                                SizedBox(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height *
                                      0.010,
                                ),
                                CustomButton(
                                    text: 'Sign Up',
                                    onTap: () {
                                      if (_signupField.currentState!
                                          .validate()) {
                                        //signUpUser();
                                      }
                                    }),
                                SizedBox(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height *
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
      controller: _passwordController,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Password require';
        } else if (val.length < 8) {
          return 'password must be at least  8 characters';
        }
        return null;
      },
      onChanged: (value) {
        _password = value;
      },
      decoration: const InputDecoration(
        hintText: 'Enter password',
        labelText: 'password',
        icon: Icon(Icons.lock_clock_outlined),
      ),
    );
  }

  TextFormField _confirmPasswordWidget() {
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
        _confirmPassword = value;
      },
      decoration: const InputDecoration(
        hintText: 'Confirm Password',
        labelText: 'Confirm Password',
        icon: Icon(Icons.lock_clock_outlined),
      ),
    );
  }

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
      onChanged: (value) {
        _email = value;
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
      controller: _nameController,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Name require';
        } else if (!RegExp(r'(^[a-zA-Z]*$)').hasMatch(val)) {
          return 'Name must be a-z and A-Z';
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
