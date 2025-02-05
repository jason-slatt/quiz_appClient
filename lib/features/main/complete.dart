import 'package:flutter/material.dart';
import 'package:quiz_app/constant/global_variables.dart';
import 'package:quiz_app/features/main/home.dart';

class Completed extends StatelessWidget {
  static const routeName = '/completed';

  final  List<Object> args;
  const Completed({super.key, required this.args});


  @override
  Widget build(BuildContext context) {
    // Cast arguments explicitly
    final int totalScore = args[0] as int;
    final double completionPercentage = args[1] as double;
    final int totalQuestions = args[2] as int;
    final int correctAnswers = args[3] as int;
    final int wrongAnswers = args[4] as int;
    return Scaffold(
      body: Builder(
        builder: (context) {
          return Column(
            children: [
              SizedBox(
                height: 521,
                width: 400,
                child: Stack(
                  children: [
                    Container(
                      height: 340,
                      width: 410,
                      decoration: BoxDecoration(
                        color: GlobalVariable.secondaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: CircleAvatar(
                          radius: 85,
                          backgroundColor: Colors.white.withOpacity(.3),
                          child: CircleAvatar(
                            radius: 71,
                            backgroundColor: Colors.white.withOpacity(.4),
                            child: Center(
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Your score',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: GlobalVariable.secondaryColor),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: '$totalScore',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: GlobalVariable.secondaryColor),
                                        children: const [
                                          TextSpan(
                                            text: 'pt',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: GlobalVariable.secondaryColor),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 60,
                      left: 22,
                      child: Container(
                        height: 190,
                        width: 350,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              spreadRadius: 6,
                              color: GlobalVariable.secondaryColor.withOpacity(.7),
                              offset: const Offset(0, 1),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 15,
                                                width: 15,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: GlobalVariable.secondaryColor,
                                                ),
                                              ),
                                              Text(
                                                '$completionPercentage%',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20,
                                                    color:
                                                    GlobalVariable.secondaryColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Text('Completion'),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Row(
                                            children: [
                                                Container(
                                                height: 15,
                                                width: 15,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: GlobalVariable.secondaryColor,
                                                ),
                                              ),
                                              Text(
                                                '$totalQuestions',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20,
                                                    color:
                                                    GlobalVariable.secondaryColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Text('Total Questions'),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Row(
                                            children: [
                                                Container(
                                                height: 15,
                                                width: 15,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.green),
                                              ),
                                              Text(
                                                '$correctAnswers',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20,
                                                    color: Colors.green),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Text('Correct'),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 48.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Row(
                                              children: [
                                                  Container(
                                                  height: 15,
                                                  width: 15,
                                                  decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.red),
                                                ),
                                                Text(
                                                  '$wrongAnswers',
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 20,
                                                      color: Colors.red),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Text('Wrong'),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {

                              Navigator.pushNamed(context, Home.routeName);
                            },
                            child: const CircleAvatar(
                              backgroundColor: GlobalVariable.secondaryColor,
                              radius: 35,
                              child: Center(
                                  child: Icon(
                                    Icons.refresh_sharp,
                                    size: 35,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text('Play Again',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400)),
                        ],
                      ),
                      const Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 35,
                            child: Center(
                                child: Icon(
                                  Icons.home_filled,
                                  size: 35,
                                  color: Colors.white,
                                )),
                          ),
                          SizedBox(height: 10),
                          Text('Home',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400))
                        ],
                      ),
                      const Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: GlobalVariable.secondaryColor,
                            radius: 35,
                            child: Center(
                                child: Icon(
                                  Icons.leaderboard,
                                  size: 35,
                                  color: Colors.white,
                                )),
                          ),
                          SizedBox(height: 10),
                          Text('Leader Board',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        }
      ),
    );
  }
}
