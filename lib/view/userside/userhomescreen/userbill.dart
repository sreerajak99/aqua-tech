import 'package:aquatech/components/paymentway.dart';
import 'package:aquatech/view/userside/components/billcomponent1.dart';
import 'package:aquatech/view/userside/components/billcomponent2.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Userbill extends StatelessWidget {
  Userbill({Key? key, required this.consumerid}) : super(key: key);

  final FirebaseFirestore firedata = FirebaseFirestore.instance;
  final FirebaseAuth authdata = FirebaseAuth.instance;
  final String consumerid;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Center(
          child: Text(
            "Here is your Bill.....!",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(height: screenSize.height * 0.06),
        StreamBuilder<QuerySnapshot>(
          stream: firedata
              .collection("bll store")
              .doc(consumerid)
              .collection("bill")
              .orderBy("created", descending: true)
              .limit(1) // Add this line to get only the latest document
              .snapshots(),
          builder: (context, billSnapshot) {
            if (billSnapshot.hasError) {
              return Text('Error: ${billSnapshot.error}');
            }

            if (billSnapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (!billSnapshot.hasData || billSnapshot.data!.docs.isEmpty) {
              return Text("No Data Found");
            }

            final data = billSnapshot.data!.docs.first.data() as Map<String, dynamic>;

            return Container(
              width: screenSize.width * 0.80,
              height: screenSize.height * 0.660,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  SizedBox(height: screenSize.height * 0.03),
                  TextComponent(
                    Billamount: data["amount"] ?? "Not available",
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 10),
                    child: Column(
                      children: [
                        Billlcomponent2(
                          text1: "Consumer Name : ",
                          text2: data['consumerName'] ?? "Not available",
                        ),
                        Billlcomponent2(
                          text1: "Consumer id : ",
                          text2: data["consumerID"] ?? "Not available",
                        ),
                        Billlcomponent2(
                          text1: "Address : ",
                          text2: data["consumerAdress"] ?? "Not available",
                        ),
                        Billlcomponent2(
                          text1: "Total Usage : ",
                          text2: data["usage"] ?? "Not Available",
                        ),
                        Billlcomponent2(
                          text1: "Bill Date : ",
                          text2: formatTimestamp(data["created"]),
                        ),
                        Billlcomponent2(
                          text1: "Due Date : ",
                          text2: calculateDueDate(data["created"]),
                        ),
                        Billlcomponent2(
                          text1: "Previous Usage : ",
                          text2: data["previousreading"] ?? "Not available",
                        ),
                        Billlcomponent2(
                          text1: "Current Usage : ",
                          text2: data["currentreading"] ?? "Not available",
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

String formatTimestamp(dynamic timestamp) {
  if (timestamp == null) return "Not available";
  if (timestamp is Timestamp) {
    DateTime dateTime = timestamp.toDate();
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }
  return "Not available";
}

String calculateDueDate(dynamic timestamp) {
  if (timestamp == null) return "Not available";
  if (timestamp is Timestamp) {
    DateTime billDate = timestamp.toDate();
    DateTime dueDate = billDate.add(Duration(days: 30));
    return "${dueDate.day}/${dueDate.month}/${dueDate.year}";
  }
  return "Not available";
}