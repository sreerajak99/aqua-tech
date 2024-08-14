import 'package:aquatech/view/adminside/animatedadmincontainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottambarAdmin extends StatelessWidget {
  final VoidCallback Onpresshome;
  final VoidCallback Onpressuser;
  final VoidCallback Onpressmessage;
  int? count;

  BottambarAdmin(
      {super.key,
      required this.Onpresshome,
      required this.Onpressmessage,
      required this.Onpressuser,
      this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 319,
          height: 55,
          decoration: const BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Row(
            children: [
              SizedBox(
                width: 3,
              ),
              AnimatedContainerAdmin(
                  Onpressed: Onpressuser,
                  icondata: Icon(CupertinoIcons.group),
                  functionName: "list",
                  height: 48,
                  width: count == 0 ? 120 : 90,
                  colordata:
                      count == 0 ? Colors.white : Colors.lightBlueAccent),
              SizedBox(
                width: 5,
              ),
              AnimatedContainerAdmin(
                  Onpressed: Onpresshome,
                  icondata: Icon(CupertinoIcons.add),
                  functionName: "Add",
                  height: 48,
                  width: count == 1 ? 120 : 90,
                  colordata:
                      count == 1 ? Colors.white : Colors.lightBlueAccent),
              SizedBox(
                width: 7,
              ),
              AnimatedContainerAdmin(
                  Onpressed: Onpressmessage,
                  icondata: Icon(Icons.list_alt_outlined),
                  functionName: "Complaints",
                  height: 48,
                  width: count == 2 ? 120 : 90,
                  colordata: count == 2 ? Colors.white : Colors.lightBlueAccent)
            ],
          ),
        )
      ],
    );
  }
}
