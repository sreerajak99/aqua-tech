import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class BillPage extends StatelessWidget {
  final String consumerId;

  BillPage({Key? key, required this.consumerId}) : super(key: key);

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("bll store")
            .doc(consumerId)
            .collection("bill")
            .orderBy("created", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No bill data available'));
          }

          final billData = snapshot.data!.docs.first.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildHeader(billData),
                  SizedBox(height: 20),
                  buildConsumerInfo(consumerId),
                  SizedBox(height: 20),
                  buildUsageInfo(billData),
                  SizedBox(height: 20),
                  buildPaymentInfo(billData),
                  SizedBox(height: 20),
                  buildPaymentButton(context, billData),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildHeader(Map<String, dynamic> billData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'AquaTech Water Bill',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          'Bill Amount: ${billData['amount'] ?? 'N/A'}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
      ],
    );
  }
  Widget buildConsumerInfo(String consumerId) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('Userlist')  // Adjust this to your actual collection name
          .where("consumerid", isEqualTo: consumerId)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No consumer data available'));
        }

        final billData = snapshot.data!.docs.first.data();

        return Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Consumer Information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                buildInfoRow('Name', billData['name'] ?? 'N/A'),
                buildInfoRow('ID', billData['consumerid'] ?? 'N/A'),
                buildInfoRow('Address', billData['Address'] ?? 'N/A'),
                buildInfoRow('Email', billData['email'] ?? 'N/A'),

              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
          Text(value),
        ],
      ),
    );
  }

  Widget buildUsageInfo(Map<String, dynamic> billData) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Usage Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            buildInfoRow('Previous Reading', billData['previousreading'] ?? 'N/A'),
            buildInfoRow('Current Reading', billData['currentreading'] ?? 'N/A'),
            buildInfoRow('Total Usage', billData['usage'] ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  Widget buildPaymentInfo(Map<String, dynamic> billData) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Payment Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            buildInfoRow('Bill Date', formatDate(billData['created'])),
            buildInfoRow('Due Date', calculateDueDate(billData['created'])),
            buildInfoRow('Amount Due', 'RS ${billData['amount'] ?? 'N/A'}'),
          ],
        ),
      ),
    );
  }



  Widget buildPaymentButton(BuildContext context, Map<String, dynamic> billData) {
    return Center(
      child: ElevatedButton(   style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
              Colors.lightBlueAccent)),

        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Payment feature coming soon!')),
          );
        },
        child: Text('Pay Bill',style: TextStyle(color: Colors.white),),

      ),
    );
  }

  String formatDate(dynamic timestamp) {
    if (timestamp == null) return 'N/A';
    if (timestamp is Timestamp) {
      return DateFormat('dd/MM/yyyy').format(timestamp.toDate());
    }
    return 'N/A';
  }

  String calculateDueDate(dynamic timestamp) {
    if (timestamp == null) return 'N/A';
    if (timestamp is Timestamp) {
      final dueDate = timestamp.toDate().add(Duration(days: 30));
      return DateFormat('dd/MM/yyyy').format(dueDate);
    }
    return 'N/A';
  }
}