import 'package:aquatech/components/aboutapp.dart';
import 'package:aquatech/view/begining/model.dart';
import 'package:aquatech/view/userside/components/drawercomplaint.dart';
import 'package:aquatech/view/meterreader/component/profile.dart';
import 'package:aquatech/view/userside/components/icon&text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../components/apptext.dart';

class DrawerdataMeter extends StatelessWidget {
  const DrawerdataMeter({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      surfaceTintColor: Colors.lightBlueAccent,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(color: Colors.lightBlueAccent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 50),
                    child: CircleAvatar(
                      radius: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, top: 3),
                    child: AppText(teXt: name),
                  )
                ],
              ),
            ),
            IconAndText(
              icoN: Icon(Icons.person),
              TExt: "My Profile",
              TextPressd: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ));
              },
              Onpressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ));
              },
            ),

            IconAndText(
              icoN: Icon(Icons.logout_outlined),
              TExt: "Logout",
              TextPressd: () {
                logoutfunction(context);
              },
              Onpressed: () {
                logoutfunction(context);
              },
            ),
            IconAndText(
              icoN: Icon(Icons.dock_outlined),
              TExt: "About Aqua Track",
              TextPressd: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AboutAppPage(),
                ));
              },
              Onpressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AboutAppPage(),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> logout() async {
  await FirebaseAuth.instance.signOut();
}

Future<void> logoutfunction(BuildContext context) async {
  await logout(); // Call your user data clearing function here
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => Getstart()),
  );
}
