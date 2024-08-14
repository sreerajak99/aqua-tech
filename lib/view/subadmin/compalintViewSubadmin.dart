import 'package:aquatech/components/apptext.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ComplaintViewSub extends StatelessWidget {
  const ComplaintViewSub({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: AppText(
          teXt: "Complaint",
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 600,width: 360,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Users")
                      .snapshots(),
                  builder: (context, snapshot) {
                    return ListView.separated(itemBuilder: (context, index) {
                     return ListTile(tileColor: Colors.red,);
                    }, separatorBuilder: (context, index) {
                      return SizedBox(height: 5,);
                    }, itemCount: snapshot.data?.docs.length??0);
                  },),
            )
          ],
        ),
      ),
    );
  }
}
