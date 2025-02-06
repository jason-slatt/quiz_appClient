import 'package:flutter/material.dart';
import 'package:HGArena/constant/global_variables.dart';
class Options extends StatelessWidget {
  final String options;
  const Options({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 48,
          width: 240,
          child:  Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.center ,
                      child: Text(options, style: const TextStyle( fontWeight:  FontWeight.bold),)
                  ),
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
