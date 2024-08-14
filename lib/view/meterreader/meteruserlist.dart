import 'package:aquatech/components/apptext.dart';
import 'package:aquatech/components/textcomponent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserlistMeterreader extends StatefulWidget {
  const UserlistMeterreader({super.key});

  @override
  _UserlistMeterreaderState createState() => _UserlistMeterreaderState();
}

class _UserlistMeterreaderState extends State<UserlistMeterreader> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(
          "Consumer details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by name or consumer ID',
                prefixIcon: Icon(Icons.search, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
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
                      (doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final name = (data['name'] ?? '').toLowerCase();
                    final conid = (data['consumerid'] ?? '').toLowerCase();
                    return doc.id != currentUser?.uid &&
                        (name.contains(searchQuery) || conid.contains(searchQuery));
                  },
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
                    final conid = data['consumerid'] ?? 'unknown';
                    final email = data['email'] ?? 'Not Available';
                    return ListTile(
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
                                        ),
                                        Textcomponent(
                                          teXt: data['name'],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Textcomponent(
                                          teXt: " Email : ",
                                        ),
                                        Textcomponent(
                                          teXt: data['email'],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Textcomponent(
                                          teXt: " Consumer ID  : ",
                                        ),
                                        Textcomponent(
                                          teXt: data['consumerid'],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Textcomponent(
                                          teXt: " phone Number  : ",
                                        ),
                                        Textcomponent(
                                          teXt:
                                          data['phonenumber'] ?? "Unknown",
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Textcomponent(
                                          teXt: " Connection Status : ",
                                        ),
                                        Textcomponent(
                                          teXt: 'Active',
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Textcomponent(
                                          teXt: " Have any due  : ",
                                        ),
                                        Textcomponent(
                                          teXt: "no",
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
                      title: Row(
                        children: [
                          Text(
                            name,
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(width: 20),
                          Text(
                            ' ID : $conid',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        email,
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Container(
                        child: Center(child: Text('Details')),
                        height: 25,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
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