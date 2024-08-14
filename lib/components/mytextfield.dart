import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final String warning;
  IconData? suffixIcon;
  final TextEditingController controller;
  final double widtH;


  MyTextFormField(
      {Key? key,
      required this.hintText,
      this.suffixIcon,
        required this.warning,
      required this.controller,
      required this.widtH})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widtH,
      child:  Padding(
        padding:
        const EdgeInsets.only(right: 3, left: 5, top: 20),
        child: TextFormField(
          controller: controller,
         
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,

            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none),
            hintText: hintText,
            suffixIcon:Icon(suffixIcon),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return warning ;
            }
            return null;
          },
        ),
      ),
    );
  }
}
// left: 50, right: 50,top: 20
