import 'package:flutter/material.dart';

class Democomplaints extends StatelessWidget {
  const Democomplaints({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
        Container(
          height: 300,
          width: 300,
          color: Colors.white,
          child: TextFormField(
            controller: TextEditingController(),
          ),
        )
        ],),
      ) ,
    );
  }
}
