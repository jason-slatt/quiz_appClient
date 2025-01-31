import 'package:flutter/material.dart';
import 'package:quiz_app/constant/global_variables.dart';
class Options extends StatelessWidget {
  final String options;
  const Options({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 48,
          width: 240,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 3, color: GlobalVariable.secondaryColor)
          ),
          child:  Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(options, style: const TextStyle( fontWeight:  FontWeight.bold),),
                  Radio(value: options, groupValue: 2, onChanged:(val) {})
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10,)
      ],
    );
  }
}
