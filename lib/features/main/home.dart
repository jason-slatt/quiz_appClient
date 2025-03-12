import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:HGArena/constant/global_variables.dart';
import 'package:HGArena/features/main/complete.dart';
import 'package:HGArena/features/main/option.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  final List<dynamic> args;
  static const routeName = '/home';
  const Home({super.key, required this.args});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Ensure arguments are not null and categoryID is properly extracted
  late int ID;
  late String category = " ";
  int totalQuestions = 0;
  double completionPercentage = 0.0;
  int totalScore = 0;
  int number = 0;
  List responseData = [];
  late Timer _timer;
  int _secondRemaining = 15;
  List<String> shuffledOptions = [];
  int correctAnswers = 0;
  int wrongAnswers = 0;
  List<Map<String, String>> incorrectResponses = [];
  String? selectedOption;
  bool answered = false;

  @override
  void initState() {
    super.initState();
    // Safely extract arguments from widget.args
    ID = widget.args.isNotEmpty
        ? (widget.args[0] as int?) ?? 0 // Extract the first argument (ID)
        : 0; // Default to 0 if not available

    category = widget.args.length > 1
        ? (widget.args[1] as String?) ??
            "default category" // Extract the second argument (category)
        : "default category"; // Default to "default category" if not available

    api();
    startTimer();
    resetGame();
  }

  Future api() async {
    final response = await http.get(Uri.parse(
        "https://opentdb.com/api.php?amount=10&category=$ID&difficulty=easy&type=multiple"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['results'];
      setState(() {
        responseData = data;
        updateShuffleOptions();
      });
    }
  }

  void resetGame() {
    setState(() {
      totalScore = 0;
      completionPercentage = 0.0;
      totalQuestions = 0;
      correctAnswers = 0;
      wrongAnswers = 0;
    });
  }

  /*@override
    void didChangeDependencies() {
      super.didChangeDependencies();
      final args = ModalRoute.of(context)!.settings.arguments as List<dynamic>?;
      if (args != null && args[]== true) {
        resetGame();  // Reset game if needed
      }
    }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(category),
          backgroundColor: GlobalVariable.secondaryColor,
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Column(children: [
              SizedBox(
                  height: 280,
                  width: 400,
                  child: Stack(children: [
                    Container(
                        height: 340,
                        width: 410,
                        decoration: const BoxDecoration(
                          color: GlobalVariable.secondaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.zero,
                              topRight: Radius.zero,
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                        )),
                    Positioned(
                        bottom: -3,
                        left: 22,
                        child: Container(
                            height: 170,
                            width: 350,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.zero,
                                  topRight: Radius.zero,
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  spreadRadius: 6,
                                  color: GlobalVariable.secondaryColor
                                      .withOpacity(.7),
                                  offset: const Offset(0, 1),
                                )
                              ],
                            ),
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 18),
                                child: Column(children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(correctAnswers.toString(),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.green)),
                                        Text(wrongAnswers.toString(),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.red)),
                                      ]),
                                  Center(
                                    child: Text(
                                      'questions ${number + 1}/${responseData.length}',
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.blue),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    responseData.isNotEmpty
                                        ? responseData[number]['question'] ??
                                            'loading please wait'
                                        : 'no data',
                                    style: const TextStyle(color: Colors.black),
                                  )
                                ])))),
                    Positioned(
                        bottom: 130,
                        left: 140,
                        child: CircleAvatar(
                            radius: 42,
                            backgroundColor: Colors.white,
                            child: Center(
                              child: Text(
                                _secondRemaining.toString(),
                                style: const TextStyle(
                                    fontSize: 25, color: Colors.blue),
                              ),
                            )))
                  ])),
              const SizedBox(height: 10),
              Column(
                children: (responseData.isNotEmpty &&
                        responseData[number]['incorrect_answers'] != null)
                    ? shuffledOptions.map((option) {
                        return GestureDetector(
                          onTap: answered ? null : () => checkAnswer(option),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0), // Adds spacing between options
                            decoration: BoxDecoration(
                              color: selectedOption != null
                                  ? (option ==
                                          responseData[number]['correct_answer']
                                      ? Colors.green
                                      : (selectedOption == option
                                          ? Colors.red
                                          : Colors.transparent))
                                  : Colors.transparent, // Default no color
                              borderRadius: BorderRadius.circular(
                                  8.0), // Makes corners rounded for symmetry
                              border: Border.all(
                                color: Colors.black.withOpacity(
                                    0.2), // Subtle border for better clarity
                              ),
                            ),
                            child: Options(options: option.toString()),
                          ),
                        );
                      }).toList()
                    : [const Text("No options available")],
              ),
              const SizedBox(height: 30),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        padding: const WidgetStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    onPressed: nextQuestion,
                    child: const Text('Next', style: TextStyle(fontSize: 20)),
                  ))
            ])));
  }

  void checkAnswer(String selected) {
    setState(() {
      selectedOption = selected;
      answered = true;
      String correctAnswer = responseData[number]['correct_answer'];
      if (selected == correctAnswer) {
        correctAnswers++;
      } else {
        wrongAnswers++;
        incorrectResponses.add({
          'question': responseData[number]['question'],
          'correct': correctAnswer,
          'wrong': selected,
        });
      }
    });
  }

  bool isCompleted = false;

  void nextQuestion() {
    if (number < responseData.length - 1) {
      setState(() {
        number++;
        updateShuffleOptions();
        _secondRemaining = 15;
        selectedOption = null;
        answered = false;
      });
    } else if (number == responseData.length - 1 && !isCompleted) {
      setState(() {
        isCompleted = true;
      });
      completed();
    }
  }

  void completed() {
    ID;
    category;

    _timer.cancel();

    totalQuestions = responseData.length;
    completionPercentage = (correctAnswers / totalQuestions) * 100;
    totalScore = correctAnswers; // Assuming 1 point per correct answer

    List<Map<String, String>> correctResponses = [];

    for (int i = 0; i < responseData.length; i++) {
      String correctAnswer = responseData[i]['correct_answer'];
      bool isWrong = incorrectResponses
          .any((item) => item['question'] == responseData[i]['question']);

      if (!isWrong) {
        correctResponses.add({
          'question': responseData[i]['question'],
          'correct': correctAnswer,
        });
      }
    }

    Navigator.pushNamed(
      context,
      Completed.routeName,
      arguments: [
        totalScore,
        completionPercentage,
        totalQuestions,
        correctAnswers,
        wrongAnswers,
        ID,
        category,
      ],
    );
  }

  void updateShuffleOptions() {
    if (responseData.isNotEmpty && number < responseData.length) {
      setState(() {
        shuffledOptions = shuffleOptions([
          responseData[number]['correct_answer'],
          ...(responseData[number]['incorrect_answers'] as List)
        ]);
      });
    }
  }

  List<String> shuffleOptions(List<String> option) {
    List<String> shuffledOptions = List.from(option);
    shuffledOptions.shuffle();
    return shuffledOptions;
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondRemaining > 0) {
          _secondRemaining--;
        } else {
          nextQuestion();
          _secondRemaining = 15;
        }
      });
    });
  }
}
