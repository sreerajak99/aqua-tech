import 'package:aquatech/view/meterreader/meterreader_homescreen.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'meterreader_state.dart';

class MeterreaderCubit extends Cubit<MeterreaderState> {
  MeterreaderCubit(this.metercontext) : super(MeterreaderInitial());
  BuildContext metercontext;
  final consumerNameController = TextEditingController();
  final consumeridController = TextEditingController();
  final consumerAddressController = TextEditingController();
  final previousReadingController = TextEditingController();
  final currentReadingController = TextEditingController();
  final complaintcontroller = TextEditingController();
  var amount;

  calculationAmount() {
    StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("amountofwater")
          .orderBy("date", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        final admindata = snapshot.data?.docs.first.data();
        amount = admindata?["amount"];
        return Text("");
      },
    );
  }

  postfiredata() async {
    final usage = int.parse(currentReadingController.text) -
        int.parse(previousReadingController.text);
    await FirebaseFirestore.instance
        .collection("bll store")
        .doc(consumeridController.text)
        .collection("bill")
        .add({
      "consumerName": consumerNameController.text,
      "consumerID": consumeridController.text,
      "consumerAdress": consumerAddressController.text,
      "previousreading": previousReadingController.text,
      "currentreading": currentReadingController.text,
      "created": FieldValue.serverTimestamp(),
      "usage": usage.toString(),
      "amount": (usage * 2).toString()
    });
  }

  popup(String head, String title) {
    showDialog(
      context: metercontext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(head),
          content: Text(title),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MeterReaderHome(),
                )); // Close the pop-up
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  complaintMeterreader() async {
    await FirebaseFirestore.instance
        .collection("meterreadercomplaints")
        .doc(consumeridController.text)
        .set({
      "consumerName": consumerNameController.text,
      "consumerID": consumeridController.text,
      "consumerAdress": consumerAddressController.text,
      "complaint": complaintcontroller.text,
      "date": FieldValue.serverTimestamp(),
    });
  }
}
