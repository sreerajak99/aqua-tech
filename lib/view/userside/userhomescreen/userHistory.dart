import 'package:aquatech/components/apptext.dart';
import 'package:aquatech/components/graph.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Userhistory extends StatelessWidget {
  const Userhistory({Key? key, required this.consumerId}) : super(key: key);

  final String consumerId;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 40),
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("bll store")
                  .doc(consumerId)
                  .collection("bill")
                  .orderBy("created", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                final bills = snapshot.data!.docs;
                final List<double> usageList = [];


                for (var bill in bills) {
                  final billData = bill.data() as Map<String, dynamic>;
                  final usage = double.tryParse(billData["usage"].toString()) ?? 0.0;

                  if (usageList.length < 12) {
                    usageList.insert(0, usage);
                  } else {

                    usageList.clear();
                    usageList.add(usage);
                  }
                }

                return Column(
                  children: [
                    SizedBox(height: 20),
                    WaterUsageGraph(monthlyUsage: usageList),
                    SizedBox(height: 20),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(height: 5),
                        itemCount: bills.length,
                        itemBuilder: (context, index) {
                          final billData = bills[index].data() as Map<String, dynamic>;
                          final usage = billData["usage"];
                          final amount = billData["amount"];
                          final date = formatTimestamp(billData["created"]);

                          return ExpansionTileTheme(
                              data: ExpansionTileThemeData(
                                shape: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(16)
                                ),
                                backgroundColor: Colors.transparent,
                              ),
                              child: ExpansionTile(
                                tilePadding: EdgeInsets.symmetric(horizontal: 11.0),
                                title: Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    '$date',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                children: [
                                  Container(
                                    width: 400,
                                    color: Colors.lightBlueAccent.withOpacity(0.2),
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        Text("$usage - unit"),
                                        Text("$amount Rs")
                                      ],
                                    ),
                                  ),
                                ],
                              )
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
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

// Note: calculateDueDate function removed as it wasn't used in this widget