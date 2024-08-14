import 'package:flutter/material.dart';

class EmailTextField extends StatefulWidget {
  final String hintText;
  final IconData? suffixIcon;
  final TextEditingController controller;
  final double width;
  final bool isEmail;

  const EmailTextField({
    Key? key,
    required this.hintText,
    this.suffixIcon,
    required this.controller,
    required this.width,
    this.isEmail = false,
  }) : super(key: key);

  @override
  EmailTextFieldState createState() => EmailTextFieldState();
}

class EmailTextFieldState extends State<EmailTextField> {
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Padding(
        padding: const EdgeInsets.only(right: 3, left: 5, top: 20),
        child: TextField(
          controller: widget.controller,
          keyboardType: widget.isEmail ? TextInputType.emailAddress : TextInputType.text,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
          
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
            hintText: widget.hintText,
            suffixIcon: Icon(widget.suffixIcon),
            errorText: _errorText,
          ),
          onChanged: (value) {
            setState(() {
              if (value.isEmpty) {
                _errorText = 'This field is required';
              } else if (widget.isEmail && !_isValidEmail(value)) {
                _errorText = 'Please enter a valid email address';
              } else {
                _errorText = null;
              }
            });
          },
        ),
      ),
    );
  }

  bool _isValidEmail(String email) {
    String emailPattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }
}