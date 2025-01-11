
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintext;
  final int maxline;
  const CustomTextField(
      {super.key, required this.controller, required this.hintext , this.maxline = 1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintext,
        // border: const OutlineInputBorder(borderSide: Border.symmetric(12))
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return ' Enter $hintext';
        } else {
          return null;
        }
      },
      maxLines: maxline,
    );
  }
}