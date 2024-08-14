import 'package:aquatech/components/aboutapp.dart';
import 'package:aquatech/view/adminside/adminprofile.dart';
import 'package:aquatech/view/adminside/readercomplaints.dart';
import 'package:aquatech/view/adminside/userdataentry.dart';
import 'package:aquatech/view/begining/model.dart';
import 'package:aquatech/view/userside/components/icon&text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../components/apptext.dart';

class DrawercontenT extends StatefulWidget {
  DrawercontenT({super.key, required this.name});

  final String name;

  @override
  State<DrawercontenT> createState() => _DrawercontenTState();
}

class _DrawercontenTState extends State<DrawercontenT> {
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
                    child: AppText(teXt: widget.name),
                  )
                ],
              ),
            ),
            IconAndText(
              icoN: Icon(Icons.person),
              TExt: "My Profile",
              TextPressd: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AdminProfilePage(),
                ));
              },
              Onpressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AdminProfilePage(),
                ));
              },
            ),
            IconAndText(
              icoN: Icon(Icons.view_timeline_outlined),
              TExt: " Change The Amount",
              TextPressd: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    final controller = TextEditingController();
                    return AlertDialog(
                      title: Text('Change The Amount'),
                      content: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controller,
                      ),
                      actions: [
                        TextButton(
                          child: Text('Done'),
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection("amountofwater")
                                .add({
                              "amount": controller.text,
                              "date": FieldValue.serverTimestamp()
                            });Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              Onpressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    final controller = TextEditingController();
                    return AlertDialog(
                      title: Text('Change The Amount'),
                      content: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controller,
                      ),
                      actions: [
                        TextButton(
                          child: Text('Done'),
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection("amountofwater")
                                .add({
                              "amount": controller.text,
                              "date": FieldValue.serverTimestamp()
                            });Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            IconAndText(
              icoN: Icon(Icons.add_box_outlined),
              TExt: "Add New Consumer Details",
              TextPressd: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UserDataEntryPortal(),
                ));
              },
              Onpressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UserDataEntryPortal(),
                ));
              },
            ),
            IconAndText(
              icoN: Icon(Icons.list_alt_rounded),
              TExt: "Reader Complaints",
              TextPressd:() {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Readercompalints(),
                ));
              },
              Onpressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Readercompalints(),
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
