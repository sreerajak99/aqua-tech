import 'package:aquatech/components/apptext.dart';
import 'package:aquatech/view/adminside/admin_complaint_view_section.dart';
import 'package:aquatech/view/begining/model.dart';

import 'package:aquatech/view/meterreader/component/appbarcomponent.dart';
import 'package:aquatech/view/meterreader/component/home.dart';

import 'package:aquatech/view/subadmin/addmeterresder.dart';
import 'package:aquatech/view/subadmin/profilesection.dart';

import 'package:aquatech/view/subadmin/userlistsubadmin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../meterreader/component/meterreaderdrawerdata.dart';

class SubadminHomescreen extends StatelessWidget {
  const SubadminHomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  child: Center(
                      child: AppText(
                    teXt: "Aqua Tech",
                    color: Colors.white,
                    size: 20,
                  )),
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16))),
                ),
                Positioned(
                    top: 29,
                    left: 300,
                    child: TextButton(
                        onPressed: () {
                          logoutfunction(context);
                        },
                        child: Text(
                          "Logout",
                          style: TextStyle(color: Colors.white,fontSize: 10),
                        ))),
                Positioned(
                    top: 170,
                    left: 50,
                    child: Row(
                      children: [
                        Appbarcmp(
                          icondata: Icon(CupertinoIcons.group),
                          TExt: "User List",
                          textcolor: Colors.white,
                          Onpressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UserListSubadmin()));
                          },
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Appbarcmp(
                          icondata: Icon(CupertinoIcons.person),
                          TExt: " Profile",
                          textcolor: Colors.white,
                          Onpressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Profileset()));
                          },
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Appbarcmp(
                          icondata: Icon(CupertinoIcons.person_add),
                          TExt: "Add reader",
                          textcolor: Colors.white,
                          Onpressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AddMeterReader()));
                          },
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Appbarcmp(
                          icondata: Icon(Icons.article_outlined),
                          TExt: "Complaints",
                          textcolor: Colors.white,
                          Onpressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AdminComplaintsScreen()));
                          },
                        ),
                      ],
                    )),
              ],
            ),
            SizedBox(
              child: AppText(
                teXt: "  ",
                color: Colors.black,
              ),
              height: 25,
            ),
            ImageSwitcher(),
            SizedBox(
              height: 4,
            ),
            ImageSwitcher()
          ],
        ),
      ),
    );
  }
}

Future<void> logoutfunction(BuildContext context) async {
  await logout(); // Call your user data clearing function here
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => Getstart()),
  );
}
