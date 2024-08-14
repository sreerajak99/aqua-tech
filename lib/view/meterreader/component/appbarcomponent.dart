import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Appbarcmp extends StatelessWidget {
  Appbarcmp(
      {super.key,
      required this.icondata,
      required this.TExt,required this.textcolor,
      required this.Onpressed});

  final String TExt;
  final Icon icondata;
  final VoidCallback Onpressed;
  final Color textcolor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: IconButton(onPressed: Onpressed, icon: icondata),
        ),
        Text(TExt,style: TextStyle( color:  textcolor),)
      ],
    );
  }
}
