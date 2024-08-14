import 'package:aquatech/components/apptext.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminComplaintsScreen extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: AppText(teXt: ''),
        title: AppText(
          teXt: 'Complaints',
          color: Colors.lightBlueAccent,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collectionGroup('complaint').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          final complaints = snapshot.data!.docs;

          return ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            itemCount: complaints.length,
            itemBuilder: (context, index) {
              final complaint =
                  complaints[index].data() as Map<String, dynamic>;
              final subject = complaint['subject'];
              final description = complaint['complaints'];
              final userId = complaints[index].reference.parent.parent!.id;

              return Card(
                elevation: 2,
                color: Colors.lightBlueAccent,
                child: ExpansionTileTheme(
                  data: ExpansionTileThemeData(
                      shape: OutlineInputBorder(borderSide: BorderSide.none)),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.symmetric(horizontal: 10.0),
                    title: Text(
                      '$subject',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    children: [
                      Container(
                        width: 400,
                        color: Colors.lightBlueAccent.withOpacity(0.2),
                        padding: EdgeInsets.all(16.0),
                        child: Text(description),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
