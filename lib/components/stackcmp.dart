import 'package:aquatech/view/Loginregister/LoginRegisterSwitchButton.dart';
import 'package:aquatech/view/Loginregister/loginorregister.dart';
import 'package:flutter/material.dart';

bool? flag;

class Stackcmp extends StatefulWidget {
  const Stackcmp({super.key});

  @override
  State<Stackcmp> createState() => _StackcmpState();
}

class _StackcmpState extends State<Stackcmp> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage("assetimage/shutterstock_139888759 1.png"),
                  fit: BoxFit.fill)),
        ),
        Positioned(
            top: 100,
            left: 105,
            child: Center(
              child: Text(
                "Aqua Tech",
                style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .5),
              ),
            )),
        Positioned(
          top: 144,
          left: 157,
          child: Text(
            "SecureWater",
            style: TextStyle(fontSize: 7, letterSpacing: 5),
          ),
        ),
        Positioned(
            top: 600,
            left: 100,
            child: Column(
              children: [
                LoginRegisterButton(
                  Ontapregister: () {
                    flag = false;
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Loginorregister(),
                    ));
                    setState(() {});
                  },OntapLogin: () {
                    flag=true;
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Loginorregister(),
                  ));
                  setState(() {

                  });
                  },
                ),
              ],
            ))
      ],
    );
  }
}
