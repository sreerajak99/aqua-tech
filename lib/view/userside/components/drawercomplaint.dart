import 'package:aquatech/components/apptext.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ComplaintsScreen extends StatefulWidget {
  @override
  ComplaintsScreenState createState() => ComplaintsScreenState();
}

class ComplaintsScreenState extends State<ComplaintsScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(
          'Complaints You Registerd',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection('Users')
            .doc(auth.currentUser!.uid)
            .collection('complaint')
            .snapshots(),
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

              return Card(
                elevation: 2,
                color: Colors.lightBlueAccent,
                child: ExpansionTileTheme(
                  data: ExpansionTileThemeData(
                    shape: OutlineInputBorder(borderSide: BorderSide.none
                    )
                  ),
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
