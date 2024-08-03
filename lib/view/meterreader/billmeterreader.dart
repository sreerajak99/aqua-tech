import 'package:aquatech/components/apptext.dart';
import 'package:flutter/material.dart';

class NewBillmeterreadder extends StatelessWidget {
  const NewBillmeterreadder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: const AssetImage("assetimage/download.jpeg")),
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(16),
                bottomLeft: Radius.circular(16))),
        child: Padding(
          padding: const EdgeInsets.only(left: 30, top: 150),
          child: AppText(
            teXt: "NEW BILLL",
            color: Colors.white,
            size: 18,
          ),
        ),
      ),
    );
  }
}
