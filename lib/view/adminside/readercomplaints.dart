import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Readercompalints extends StatelessWidget {
  Readercompalints({super.key});

  final countdata = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complaints From Meter Reader ",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('meterreadercomplaints')
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
            itemBuilder: (context, index) {
              final contents = complaints[index].data() as Map<String, dynamic>;
              final name = contents['consumerName'];
              final iD = contents['consumerID'];
              final discription = contents['complaint'];
              return Card(
                elevation: 3,
                color: Colors.lightBlueAccent,
                child: ExpansionTileTheme(
                  data: ExpansionTileThemeData(
                      shape: OutlineInputBorder(borderSide: BorderSide.none)),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.symmetric(horizontal: 20.0),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        Text(
                          'consumer id : $iD',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                    children: [
                      Container(
                        width: 400,
                        color: Colors.lightBlueAccent.withOpacity(0.2),
                        padding: EdgeInsets.all(16.0),
                        child: Text(discription),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            itemCount: complaints.length,
          );
        },
      ),
    );
  }
}
