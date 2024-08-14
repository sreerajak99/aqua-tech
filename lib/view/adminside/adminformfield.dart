import 'package:flutter/material.dart';

class AdminFormfield extends StatelessWidget {
  final String hintText;
  IconData? suffixIcon;
  final TextEditingController controller;
  final double widtH;
  final TextInputType
  keyboardType;
  AdminFormfield(
      {Key? key,
      required this.hintText,
      this.suffixIcon,
      required this.controller,
      required this.widtH,required this.keyboardType
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widtH,
      decoration: BoxDecoration(
          color: Colors.transparent, borderRadius: BorderRadius.circular(16)),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.lightBlueAccent)),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 17.0),
          border: OutlineInputBorder(borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20.0),

          ),
          suffixIcon: Icon(suffixIcon),
        ),
      ),
    );
  }
}
// left: 50, right: 50,top: 20
