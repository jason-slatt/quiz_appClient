import 'package:flutter/material.dart';

class GlobalVariable{
static const secondaryColor = Color.fromRGBO(255, 165, 0, 1.0) ; // Orange;
static const backgroundColor = Color.fromRGBO(255, 255, 255, 1);
static const selectedNavBarColor = Colors.black;
static const unSelectedNavBarColor = Colors.grey;

final List<Map<String, dynamic>> categories = [
  {'id': 21,'name': 'Sports', 'questions': 50, 'icon': Icons.sports_basketball},
  {'id': 17, 'name': 'Chemistry', 'questions': 30, 'icon': Icons.science},
  {'id': 19,'name': 'Math', 'questions': 95, 'icon': Icons.calculate},
  {'id': 23, 'name': 'History', 'questions': 128, 'icon': Icons.history_edu},
  {'id': 26, 'name': 'Celebrities', 'questions': 30, 'icon': Icons.biotech},
  {'id': 22,'name': 'Geography', 'questions': 24, 'icon': Icons.map},
];

}

