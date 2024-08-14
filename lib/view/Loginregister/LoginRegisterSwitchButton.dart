import 'package:aquatech/components/stackcmp.dart';
import 'package:flutter/material.dart';

class LoginRegisterButton extends StatelessWidget {
  final VoidCallback OntapLogin;
  final VoidCallback Ontapregister;

  LoginRegisterButton({
    super.key,
    required this.OntapLogin,
    required this.Ontapregister,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: Center(
            child: Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  InkWell(
                    onTap: OntapLogin,
                    child: Container(
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: flag == true ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      height: 49,
                      width: 99,
                      decoration: BoxDecoration(
                          color: flag == true
                              ? Colors.lightBlueAccent
                              : Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15))),
                    ),
                  ),
                  InkWell(
                    onTap: Ontapregister,
                    child: Container(
                      child: Center(
                        child: Text(
                          "Register",
                          style: TextStyle(
                              color:
                                  flag == false ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      height: 49,
                      width: 99,
                      decoration: BoxDecoration(
                          color: flag == false
                              ? Colors.lightBlueAccent
                              : Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
