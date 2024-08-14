import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyconsumerField extends StatefulWidget {
  final String hintText;
  final String warning;

  final TextEditingController controller;
  final double widtH;

  MyconsumerField(
      {Key? key,
        required this.hintText,
        required this.warning,
        required this.controller,
        required this.widtH})
      : super(key: key);

  @override
  State<MyconsumerField> createState() => _MyconsumerFieldState();
}

class _MyconsumerFieldState extends State<MyconsumerField> {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firedata = FirebaseFirestore.instance;
    return SizedBox(
      width: widget.widtH,
      child: Padding(
        padding: const EdgeInsets.only(right: 3, left: 5, top: 20),
        child: TextFormField(
          controller: widget.controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none),
            hintText: widget.hintText,
          ),
          validator: (value) {

            if (value == null || value.isEmpty) {
              return widget.warning;
            }
            return null;
          },
        ),
      ),
    );
  }
}
// left: 50, right: 50,top: 20