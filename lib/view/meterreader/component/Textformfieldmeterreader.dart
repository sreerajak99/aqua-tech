import 'package:flutter/material.dart';

class AppTextformfield extends StatelessWidget {
  const AppTextformfield({
    super.key,
    required this.controller,
    required this.warning,
    required this.labeltext,
     this.maxlinE,
     this.keyboardType
  });

  final TextEditingController controller;
  final int? maxlinE;
  final String labeltext;
  final String warning;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxlinE,
      keyboardType:keyboardType ,
      decoration: InputDecoration(
        labelText: labeltext,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return warning;
        }
        return null;
      },
    );
  }
}
