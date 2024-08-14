import 'package:aquatech/components/apptext.dart';
import 'package:aquatech/components/textcomponent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserListSubadmin extends StatelessWidget {
  const UserListSubadmin({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            height: 600,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: StreamBuilder(
              stream: firestore
                  .collection("Userlist")
                  .where('rool', isEqualTo: 'user')
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

                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 4);
                  },
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final document = documents.elementAt(index);
                    final data = document.data() as Map<String, dynamic>;
                    final name = data['name'] ?? 'Unknown';
final email=data['email']??'N/A';
                    return Material(
                      color: Colors.transparent,
                      child: ListTile(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: AppText(teXt: "User Details"),
                                content: Container(
                                  height: 200,
                                  width: 250,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Textcomponent(
                                            teXt: " Name : ",
                                            size: 20,
                                          ),
                                          Textcomponent(
                                            teXt: data['name'],
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Textcomponent(
                                            teXt: " Email : ",
                                            size: 20,
                                          ),
                                          Textcomponent(
                                            teXt: data['email'],
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Textcomponent(
                                            teXt: " Consumer ID  : ",
                                            size: 20,
                                          ),
                                          Textcomponent(
                                            teXt: data['consumerid'],
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Textcomponent(
                                            teXt: " phone Number  : ",
                                            size: 20,
                                          ),
                                          Textcomponent(
                                            teXt: data['name'],
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Textcomponent(
                                            teXt: " Connection Status : ",
                                            size: 20,
                                          ),
                                          Textcomponent(
                                            teXt: 'Active',
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Textcomponent(
                                            teXt: " Have any due  : ",
                                            size: 20,
                                          ),
                                          Textcomponent(
                                            teXt: "no",
                                            size: 20,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        tileColor: Colors.lightBlueAccent,
                        title: Text(name),
                        subtitle: Text(email),
                        trailing: Container(
                          child: Center(child: Text('Details')),
                          height: 25,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
