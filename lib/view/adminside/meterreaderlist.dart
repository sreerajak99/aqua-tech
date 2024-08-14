
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MeterReaderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final currentUser = FirebaseAuth.instance.currentUser;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 4),
          Container(
            height: 600,
            width: 480,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: StreamBuilder(
              stream: firestore
                  .collection("Userlist")
                  .where('rool', isEqualTo: 'meterreader')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No users found'));
                }

                final documents = snapshot.data!.docs.where(
                      (doc) =>
                  doc.id !=
                      currentUser?.uid, // Exclude the current user's document
                );
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 4);
                    },
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final document = documents.elementAt(index);
                      final data = document.data() as Map<String, dynamic>;
                      final name = data['name'] ?? 'Unknown';
                      final couId = data['consumerid'];
                      final email = data['email'] ?? 'No email';
                      return ListTile(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Meter Reader Details"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Name: $name"),
                                    Text("Email: $email"),
                                    Text("id :$couId"),
                                    // Add more details as needed
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    child: Text("Close"),
                                    onPressed: () => Navigator.of(context).pop(),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        tileColor: Colors.lightBlueAccent,
                        title: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            name,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            email,
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                        trailing: Container(
                          child: Center(child: Text("Details")),
                          height: 25,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      );
                    },
                  ),
                );

              },
            ),
          ),
        ],
      ),
    );
  }
}