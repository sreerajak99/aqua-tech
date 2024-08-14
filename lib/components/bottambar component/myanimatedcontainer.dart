import 'package:aquatech/components/apptext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppAnimatedContainer extends StatelessWidget {
  final double wIdth;
  final double heighT;
  final Icon icondata;
  final String teXtdATA;
  final double textSize;
  final Color containercolordata;

  const AppAnimatedContainer(
      {super.key,
      required this.containercolordata,
      required this.icondata,
      required this.wIdth,
        required this.heighT,
      required this.textSize,
      required this.teXtdATA});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: wIdth,
      height: heighT,
      decoration: BoxDecoration(
          color: containercolordata, borderRadius: BorderRadius.circular(16)),
      child: Center(
        child: Column(
          verticalDirection: VerticalDirection.down,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [icondata, AppText(size: textSize, teXt: teXtdATA)],
        ),
      ),
    );
  }
}
