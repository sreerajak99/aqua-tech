import 'package:aquatech/components/apptext.dart';
import 'package:flutter/material.dart';

class TextComponent extends StatelessWidget {
   TextComponent({super.key,required this.Billamount});
final String Billamount;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppText(
            teXt: "Aqua Track",//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            size: 16,
          ),
          Text(
            "Monthly Bill",
            style: TextStyle(fontSize: 10),
          ),SizedBox(height: 5,),
          Text(Billamount
            ,//bill amount shown here.>>>>>>>>>>>>>>>>>>>>>>>>
            style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
