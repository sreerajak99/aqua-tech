import 'package:flutter/material.dart';

class MyPasswordField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final double width;

  const MyPasswordField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.width,
  }) : super(key: key);

  @override
  _MyPasswordFieldState createState() => _MyPasswordFieldState();
}

class _MyPasswordFieldState extends State<MyPasswordField> {
  bool _obscureText = true;
  String? _errorText;
  late String _password;

  @override
  void initState() {
    super.initState();
    _password = '';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Padding(
        padding: const EdgeInsets.only(right: 3, left: 5, top: 20),
        child: TextField(
          controller: widget.controller,
          obscureText: _obscureText,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,

            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
            hintText: widget.hintText,
            suffixIcon: IconButton(
              icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            errorText: _errorText,
          ),
          onChanged: (value) {
            setState(() {
              _password = value;
              _errorText = _validatePassword(value);
            });
          },
        ),
      ),
    );
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    return null;
  }
}