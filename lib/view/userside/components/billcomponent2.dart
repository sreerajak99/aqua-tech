import 'package:flutter/material.dart';

class Billlcomponent2 extends StatelessWidget {
   Billlcomponent2({super.key, required this.text1, required this.text2});

  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child:  Column(
        children: [
          Row(
            children: [
              Text(
                text1,
                style: TextStyle(fontWeight: FontWeight.w400,),
              ),
              Text(
                text2,
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
