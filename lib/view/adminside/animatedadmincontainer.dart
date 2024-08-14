import 'package:flutter/material.dart';

int countUniversal = 0;

class AnimatedContainerAdmin extends StatelessWidget {
  final Icon icondata;
  final VoidCallback Onpressed;
  final double height;
  final double width;
  final Color colordata;
final String functionName;
  const AnimatedContainerAdmin(
      {super.key,
      required this.Onpressed,
      required this.icondata,
        required this.functionName,
      required this.height,
      required this.width,
      required this.colordata});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: Onpressed,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: colordata, borderRadius: BorderRadius.circular(16)),
        child: Container(
            child: Center(
              child: Column(
                        children: [
              Center(
                child: icondata,
              ),
              Text(functionName)
                        ],
                      ),
            )),
      ),
    );
  }
}
