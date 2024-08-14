import 'package:aquatech/components/apptext.dart';
import 'package:aquatech/view/adminside/userlist.dart';
import 'package:aquatech/view/meterreader/billmeterreader.dart';
import 'package:aquatech/view/meterreader/complaint.dart';
import 'package:aquatech/view/meterreader/component/appbarcomponent.dart';
import 'package:aquatech/view/meterreader/component/home.dart';
import 'package:aquatech/view/meterreader/component/meterreaderdrawerdata.dart';
import 'package:aquatech/view/meterreader/meteruserlist.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MeterReaderHome extends StatelessWidget {
  MeterReaderHome({super.key});

  bool flag = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerdataMeter(name: "meter reader"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: screenSize.height * 0.3,
              width: screenSize.width,
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    teXt: "Aqua Tech",
                    color: Colors.white,
                    size: screenSize.width * 0.08,
                  ),
                  SizedBox(
                    height: screenSize.height * 0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                scaffoldKey.currentState?.openDrawer();
                              },
                              child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: screenSize.width * 0.06,
                                  child: Icon(Icons.person)),
                            ),
                            AppText(teXt: "Profile")
                          ],
                        ),
                        SizedBox(width: screenSize.width * 0.05),
                        Appbarcmp(
                          icondata: Icon(CupertinoIcons.arrow_down_doc),
                          TExt: "Complaint",
                          textcolor: Colors.white,
                          Onpressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ComplaintRegistrationForm(),
                            ));
                          },
                        ),
                        SizedBox(width: screenSize.width * 0.05),
                        Appbarcmp(
                          icondata: Icon(CupertinoIcons.group),
                          TExt: "User List",
                          textcolor: Colors.white,
                          Onpressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => UserlistMeterreader(),
                            ));
                          },
                        ),
                        SizedBox(width: screenSize.width * 0.05),
                        Appbarcmp(
                          icondata: Icon(Icons.receipt_long),
                          TExt: "New Bill",
                          textcolor: Colors.white,
                          Onpressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => NewBillmeterreadder(),
                            ));
                          },
                        )
                      ],
                    ),
                  ),
                ],
              )),
            ),
            SizedBox(
              height: screenSize.height * 0.01,
            ),
            Column(
              children: [
                ImageSwitcher(),
                ImageSwitcher(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
