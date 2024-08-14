import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyPhoneField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final double width;

  const MyPhoneField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.width,
  }) : super(key: key);

  @override
  _MyPhoneFieldState createState() => _MyPhoneFieldState();
}

class _MyPhoneFieldState extends State<MyPhoneField> {
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Padding(
        padding: const EdgeInsets.only(right: 3, left: 5, top: 20),
        child: TextField(
          controller: widget.controller,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,

            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
            hintText: widget.hintText,
            prefixIcon: const Icon(Icons.phone),
            errorText: _errorText,
          ),
          onChanged: (value) {
            setState(() {
              _errorText = _validatePhoneNumber(value);
            });
          },
        ),
      ),
    );
  }

  String? _validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return 'Phone number is required';
    }
    if (value.length != 10) {
      return 'Phone number must be 10 digits';
    }
    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
}