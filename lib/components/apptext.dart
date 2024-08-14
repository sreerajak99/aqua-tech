import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
   AppText({super.key, required this.teXt,this.size,this.color});

  final String teXt;
  Color ?color;
  double? size;
  @override
  Widget build(BuildContext context) {
    return Text(
      teXt,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold
      ),
    );
  }
}
