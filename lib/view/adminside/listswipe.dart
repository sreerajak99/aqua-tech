import 'package:aquatech/components/apptext.dart';
import 'package:aquatech/components/textcomponent.dart';
import 'package:aquatech/view/adminside/meterreaderlist.dart';
import 'package:aquatech/view/adminside/subadminlist.dart';
import 'package:aquatech/view/adminside/userlist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserAndMeterReaderList extends StatefulWidget {
  const UserAndMeterReaderList({Key? key}) : super(key: key);

  @override
  _UserAndMeterReaderListState createState() => _UserAndMeterReaderListState();
}

class _UserAndMeterReaderListState extends State<UserAndMeterReaderList> {
  final PageController pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(""),
        title: Text(
          currentPage == 0
              ? 'User List'
              : currentPage == 1
                  ? 'Meter Reader List'
                  : 'Sub Admin List',
          style: TextStyle(
              color: Colors.lightBlueAccent, fontWeight: FontWeight.bold),
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (int page) {
          setState(() {
            currentPage = page;
          });
        },
        children: [
          UserList(),
          MeterReaderList(),
          SubAdminList()
        ],
      ),
    );
  }
}
