import 'dart:ui';

import 'package:aquatech/components/apptext.dart';
import 'package:aquatech/view/adminside/adminformfield.dart';
import 'package:flutter/material.dart';

class AddSubAdmin extends StatelessWidget {
  final VoidCallback Onpressed;

  const AddSubAdmin(
      {super.key,
      required this.Onpressed,
      required this.emailctr,
      required this.password,
        required this.conformpassword,
      required this.SubadminId,
      required this.Name,
      required this.Surname});

  final TextEditingController emailctr;
  final TextEditingController password;
  final TextEditingController Name;
  final TextEditingController Surname;
  final TextEditingController SubadminId;
  final TextEditingController conformpassword;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: AppText(
              teXt: "Add sub admin",
              color: Colors.white,
              size: 15,
            ),
          ),
          Center(
            child: Container(
              height: 500,
              width: 370,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white, Colors.lightBlueAccent]),
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(3, 3))
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(top: 90, left: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        AdminFormfield(
                          keyboardType: TextInputType.text,
                            hintText: "Name",
                            controller:Name ,
                            widtH: 150),
                        SizedBox(
                          width: 10,
                        ),
                        AdminFormfield(
                          keyboardType: TextInputType.text,
                            hintText: "surname(optional)",
                            controller: Surname,
                            widtH: 180),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, right: 10),
                      child: AdminFormfield(
                        keyboardType: TextInputType.number,
                          hintText: "Sub Admin Id",
                          controller: SubadminId,
                          widtH: 340),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, right: 10),
                      child: AdminFormfield(
                        keyboardType: TextInputType.emailAddress,
                          hintText: "Email ",
                          controller: emailctr,
                          widtH: 340),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, right: 10),
                      child: AdminFormfield(
                        keyboardType: TextInputType.number,
                          hintText: "Password",
                          controller: password,
                          widtH: 340),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, right: 10),
                      child: AdminFormfield(
                        keyboardType: TextInputType.number,
                          hintText: "Conform Password",
                          controller:conformpassword ,
                          widtH: 340),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 228, top: 40),
                      child: ElevatedButton(
                        onPressed: Onpressed,
                        child: Text(
                          "submit",
                          style: TextStyle(color: Colors.blue),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
