import 'package:aquatech/components/mytextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loginsection extends StatefulWidget {
  final VoidCallback ? Ontap;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController username;

  const Loginsection({super.key,this.Ontap, required this.email,required this.password,required this.username});

  @override
  State<Loginsection> createState() => _LoginsectionState();
}

class _LoginsectionState extends State<Loginsection> {
   bool obscureText=true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 390,
          height: 390,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "assetimage/—Pngtree—water water ripple water droplets_3800343.png"),
                  fit: BoxFit.fill)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 260),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome Back",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
                child: MyTextFormField(
                    hintText: "Email",
                    warning: "enter the Email",
                    suffixIcon: CupertinoIcons.mail,
                    controller: widget.email,
                    widtH: 300),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 58, right: 50, top: 20),
                child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller:widget.password,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,

                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none),
                      hintText: "Password",
                      suffixIcon:IconButton(
                        icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return  "Password is required";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: InkWell(onTap: widget.Ontap,
                  child: Container(
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.lightBlueAccent.shade100,
                          Colors.white,
                          Colors.lightBlueAccent.shade100
                        ]),
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
