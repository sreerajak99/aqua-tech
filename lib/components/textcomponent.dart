import 'package:flutter/material.dart';

class Textcomponent extends StatelessWidget {
  Textcomponent({super.key, required this.teXt,this.size,this.color});

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

      ),
    );
  }
}
