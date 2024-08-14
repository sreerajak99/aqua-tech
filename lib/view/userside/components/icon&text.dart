import 'package:aquatech/components/apptext.dart';
import 'package:flutter/material.dart';

class IconAndText extends StatelessWidget {
  final Icon icoN;
  final String TExt;
  final VoidCallback Onpressed, TextPressd;

  const IconAndText(
      {super.key,
      required this.icoN,
      required this.TExt,
      required this.Onpressed,
      required this.TextPressd});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Row(
        children: [
          IconButton(onPressed: Onpressed, icon: icoN),
          SizedBox(
            width: 5,
          ),
          TextButton(onPressed: TextPressd, child: AppText(teXt: TExt,color: Colors.blue,))
        ],
      ),
    );
  }
}
